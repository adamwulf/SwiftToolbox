//
//  Signpost.swift
//
//
//  Created by Adam Wulf on 1/21/22.
//

import Foundation
import os

/// A protocol for objects that can be used to emit signposts.
public protocol Signpostable {
    /// The name of the signpost.
    var name: StaticString { get }
    @available(macOS 10.14, *)
    var id: OSSignpostID { get }
    /// Initializes a signpostable object with the given name.
    /// - Parameter name: The name of the signpost.
    init(_ name: StaticString)
    /// Finishes the signpost.
    func finish(context: [String: Any]?, file: String, function: String, line: Int, level: SwiftToolbox.LogLevel?)
    /// Emits an event with the given name.
    /// - Parameter event: The name of the event to emit.
    func emit(event: String, context: [String: Any]?, file: String, function: String, line: Int, level: SwiftToolbox.LogLevel?)
}

private class EventDurations {
    private(set) var values: [[String: CGFloat]] = []

    func tick(for event: String, duration: CGFloat) {
        values.append([event: duration])
    }
}

/// A struct that wraps the `Signpostable` protocol and provides a fallback for
/// platforms that don't support `OSSignpost`.
public struct Signpost: Signpostable {
    private static let queue = DispatchQueue(
        label: "com.musesoftware.signpostQueue",
        qos: .default,
        autoreleaseFrequency: .workItem,
        target: DispatchQueue.global())
    /// The signpostable object.
    private let signpost: Signpostable?
    private let stopwatch: StopWatch
    /// List of events and durations
    private let eventDurations = EventDurations()

    /// The name of the signpost.
    public let name: StaticString
    public let level: SwiftToolbox.LogLevel
    public let limit: TimeInterval

    @available(macOS 10.14, *)
    public var id: OSSignpostID {
        return signpost?.id ?? OSSignpostID.null
    }

    /// Initializes a signpostable object with the given name.
    /// - Parameter name: The name of the signpost.
    public init(_ name: StaticString) {
        self.init(name, level: .info)
    }

    public init(_ name: StaticString, level: SwiftToolbox.LogLevel = .info, limit: TimeInterval = .infinity) {
        self.name = name
        self.level = level
        self.limit = limit
        self.stopwatch = StopWatch.started()
        #if DEBUG
        if #available(iOS 15.0, macCatalyst 15.0, macOS 12.0, *) {
            signpost = OSSignpost(name)
        } else {
            signpost = nil
        }
        #else
        signpost = nil
        #endif
    }

    /// Finishes the signpost.
    public func finish(context: [String: Any]? = nil,
                       file: String = #file,
                       function: String = #function,
                       line: Int = #line,
                       level: SwiftToolbox.LogLevel? = nil) {
        signpost?.finish(context: context, file: file, function: function, line: line, level: level)
        let duration = stopwatch.stop()
        Self.queue.async {
            let level: SwiftToolbox.LogLevel = duration >= limit ? max(.warning, level ?? self.level) : (level ?? self.level)
            let idContext: [String: Any]
            if #available(macOS 10.14, *) {
                idContext = ["id": id.rawValue]
            } else {
                idContext = [:]
            }
            SwiftToolbox.log(level: level, message: "signpost", file: file, function: function, line: line, context: [
                "name": name,
                "status": "finished",
                "duration": duration
            ].merging(idContext).merging(context ?? [:]).merging(eventDurations.values.isEmpty ? [:] : ["events": eventDurations.values]))
        }
    }

    /// Emits an event with the given name.
    /// - Parameter event: The name of the event to emit.
    public func emit(event: String,
                     context: [String: Any]? = nil,
                     file: String = #file,
                     function: String = #function,
                     line: Int = #line,
                     level: SwiftToolbox.LogLevel? = nil) {
        signpost?.emit(event: event, context: context, file: file, function: function, line: line, level: level)
        let duration = stopwatch.read()
        Self.queue.async {
            let idContext: [String: Any]
            if #available(macOS 10.14, *) {
                idContext = ["id": id.rawValue]
            } else {
                idContext = [:]
            }
            self.eventDurations.tick(for: event, duration: duration)
            let level: SwiftToolbox.LogLevel = duration >= limit ? max(.warning, level ?? self.level) : (level ?? self.level)
            let signpostCtx: [String: Any] = ["name": name, "event": event, "status": "running", "duration": duration].merging(idContext)
            SwiftToolbox.log(level: level, message: "signpost", file: file, function: function, line: line, context: signpostCtx
                .merging(context ?? [:]))
        }
    }
}

/// An implementation of the `Signpostable` protocol that uses the `OSSignpost`
/// API.
@available(iOS 15.0, macCatalyst 15.0, macOS 12.0, *)
final class OSSignpost: Signpostable {
    /// The signposter object used to emit signposts.
    let signposter: OSSignposter
    /// The state of the signpost interval.
    let spidState: OSSignpostIntervalState
    let id: OSSignpostID
    /// A flag to indicate if the signpost has been finished.
    private var finished: Bool = false

    let name: StaticString
    init(_ name: StaticString) {
        self.name = name
        signposter = OSSignposter(subsystem: "Muse", category: .pointsOfInterest)
        id = signposter.makeSignpostID()
        spidState = signposter.beginInterval(name, id: id)
    }

    /// Finishes the signpost.
    func finish(context: [String: Any]? = nil, file: String, function: String, line: Int, level: SwiftToolbox.LogLevel? = nil) {
        guard !finished else {
            SwiftToolbox.log(level: .warning, message: "signpost", file: file, function: function, line: line, context: [
                "reason": "signpost already finalized",
                "name": name
            ])
            assertionFailure("Signpost already finished")
            return
        }
        signposter.endInterval(name, spidState)
        finished = true
    }

    /// Emits an event with the given name.
    /// - Parameter event: The name of the event to emit.
    func emit(event: String,
              context: [String: Any]? = nil,
              file: String,
              function: String,
              line: Int,
              level: SwiftToolbox.LogLevel? = nil) {
        guard !finished else {
            SwiftToolbox.log(level: .warning, message: "signpost", file: file, function: function, line: line, context: [
                "reason": "signpost already finalized",
                "name": name
            ])
            assertionFailure("Signpost already finished")
            return
        }
        signposter.emitEvent(name, id: id, "\(event)")
    }

    deinit {
        if !finished {
            #if DEBUG
            fatalError("Signpost must be finished when deallocated")
            #else
            SwiftToolbox.log(level: .error, message: "signpost", context: ["reason": "signpost was not finalized", "name": name])
            #endif
        }
    }
}

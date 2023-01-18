//
//  Signpost.swift
//
//
//  Created by Adam Wulf on 1/21/22.
//

import Foundation
import os

/// A protocol for objects that can be used to emit signposts.
protocol Signpostable {
    /// The name of the signpost.
    var name: StaticString { get }
    /// Initializes a signpostable object with the given name.
    /// - Parameter name: The name of the signpost.
    init(_ name: StaticString)
    /// Finishes the signpost.
    func finish()
    /// Emits an event with the given name.
    /// - Parameter event: The name of the event to emit.
    func emit(event: String)
}

/// A struct that wraps the `Signpostable` protocol and provides a fallback for
/// platforms that don't support `OSSignpost`.
struct Signpost: Signpostable {
    /// The signpostable object.
    private let signpost: Signpostable?
    /// The name of the signpost.
    let name: StaticString

    /// Initializes a signpostable object with the given name.
    /// - Parameter name: The name of the signpost.
    init(_ name: StaticString) {
        self.name = name
        if #available(iOS 15.0, macCatalyst 15.0, macOS 12.0, *) {
            signpost = OSSignpost(name)
        } else {
            signpost = nil
        }
    }

    /// Finishes the signpost.
    func finish() {
        signpost?.finish()
    }

    /// Emits an event with the given name.
    /// - Parameter event: The name of the event to emit.
    func emit(event: String) {
        signpost?.emit(event: event)
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
    /// A flag to indicate if the signpost has been finished.
    private var finished: Bool = false
    /// The name of the signpost.
    let name: StaticString

    /// Initializes a signpostable object with the given name.
    /// - Parameter name: The name of the signpost.
    init(_ name: StaticString) {
        self.name = name
        signposter = OSSignposter(subsystem: "Muse", category: .pointsOfInterest)
        spidState = signposter.beginInterval(name)
    }

    /// Finishes the signpost.
    func finish() {
        guard !finished else {
            assertionFailure("Signpost already finished")
            return
        }
        signposter.endInterval(name, spidState)
        finished = true
    }

    /// Emits an event with the given name.
    /// - Parameter event: The name of the event to emit.
    func emit(event: String) {
        guard !finished else {
            assertionFailure("Signpost already finished")
            return
        }
        signposter.emitEvent(name, "\(event)")
    }

    /// Asserts that the signpost has been finished when deallocated.
    deinit {
        assert(finished, "Signpost must be finished when deallocated")
    }
}

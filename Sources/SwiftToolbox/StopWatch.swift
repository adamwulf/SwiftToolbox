//
//  StopWatch.swift
//
//
//  Created by Adam Wulf on 12/9/20.
//

import Foundation

func synchronized<T>(_ lock: AnyObject, _ body: () throws -> T) rethrows -> T {
    objc_sync_enter(lock)
    defer { objc_sync_exit(lock) }
    return try body()
}

/// A class for measuring elapsed time.
public class StopWatch {
    /// The number of nanoseconds in a second.
    private let NSEC_PER_SEC = 1000000000

    /// A flag to indicate if the stopwatch is running.
    private var running = false
    /// The start time of the stopwatch.
    private var startTime: DispatchTime = .distantFuture
    /// The total duration of the stopwatch.
    private var duration: TimeInterval = 0

    public static func started() -> StopWatch {
        let watch = StopWatch()
        watch.start()
        return watch
    }

    /// Creates a new `StopWatch` instance.
    public init() {
        // noop
    }

    /// A flag to indicate if the stopwatch is running.
    public var isRunning: Bool {
        return synchronized(self) { () -> Bool in
            return running
        }
    }

    /// Starts the stopwatch.
    public func start() {
        synchronized(self) { () -> Void in
            if !isRunning {
                running = true
                startTime = DispatchTime.now()
            }
        }
    }

    /// Resets the stopwatch.
    public func reset() {
        synchronized(self) { () -> Void in
            running = false
            duration = 0
            startTime = .distantFuture
        }
    }

    /// Stops the stopwatch and returns the total duration.
    /// - Returns: The total duration of the stopwatch.
    @discardableResult
    public func stop() -> TimeInterval {
        synchronized(self) { () -> TimeInterval in
            if isRunning {
                duration = read()
                running = false
            }
            return duration
        }
    }

    /// Reads the current elapsed time.
    /// - Returns: The current elapsed time.
    public func read() -> TimeInterval {
        synchronized(self) { () -> TimeInterval in
            if isRunning {
                let endTime = DispatchTime.now()
                let elapsed: TimeInterval = {
                    if #available(macOS 10.15, *) {
                        return TimeInterval(dispatchTimeInterval: self.startTime.distance(to: endTime))
                    } else {
                        // Fallback on earlier versions
                        return TimeInterval(endTime.rawValue - self.startTime.rawValue)
                    }
                }()

                return duration + elapsed
            }
            return duration
        }
    }
}

private extension TimeInterval {
    init(dispatchTimeInterval: DispatchTimeInterval) {
        switch dispatchTimeInterval {
        case .seconds(let value):
            self = Double(value)
        case .milliseconds(let value):
            self = Double(value) / 1_000
        case .microseconds(let value):
            self = Double(value) / 1_000_000
        case .nanoseconds(let value):
            self = Double(value) / 1_000_000_000
        case .never:
            self = 0
        @unknown default:
            fatalError("Unknown case \(dispatchTimeInterval)")
        }
    }

}

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
class StopWatch {
    /// The number of nanoseconds in a second.
    private let NSEC_PER_SEC = 1000000000

    /// A flag to indicate if the stopwatch is running.
    private var running = false
    /// The start time of the stopwatch.
    private var startTime: UInt64 = 0
    /// The total duration of the stopwatch.
    private var duration: TimeInterval = 0
    /// The timebase info used to calculate elapsed time.
    private var info: mach_timebase_info_data_t

    /// Creates a new `StopWatch` instance.
    init() {
        info = mach_timebase_info_data_t()
        mach_timebase_info(&info)
    }

    /// A flag to indicate if the stopwatch is running.
    var isRunning: Bool {
        return synchronized(self) { () -> Bool in
            return running
        }
    }

    /// Starts the stopwatch.
    func start() {
        synchronized(self) { () -> Void in
            if !isRunning {
                running = true
                startTime = mach_absolute_time()
            }
        }
    }

    /// Resets the stopwatch.
    func reset() {
        synchronized(self) { () -> Void in
            running = false
            duration = 0
            startTime = 0
        }
    }

    /// Stops the stopwatch and returns the total duration.
    /// - Returns: The total duration of the stopwatch.
    @discardableResult
    func stop() -> TimeInterval {
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
    func read() -> TimeInterval {
        synchronized(self) { () -> TimeInterval in
            if isRunning {
                let endTime = mach_absolute_time()
                let elapsed = endTime - startTime
                let nanos = elapsed * UInt64(info.numer) / UInt64(info.denom)

                return duration + TimeInterval(nanos) / TimeInterval(NSEC_PER_SEC)
            }
            return duration
        }
    }
}

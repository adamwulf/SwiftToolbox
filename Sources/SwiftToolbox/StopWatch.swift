//
//  StopWatch.swift
//
//
//  Created by Adam Wulf on 12/9/20.
//

import Foundation
import CoreGraphics

func synchronized<T>(_ lock: AnyObject, _ body: () throws -> T) rethrows -> T {
    objc_sync_enter(lock)
    defer { objc_sync_exit(lock) }
    return try body()
}

class StopWatch {
    fileprivate let NSEC_PER_SEC = 1000000000

    private var running = false
    private var startTime: UInt64 = 0
    private var duration: CGFloat = 0
    private var info: mach_timebase_info_data_t

    static func start() -> StopWatch {
        let ret = StopWatch()
        ret.start()
        return ret
    }

    init() {
        info = mach_timebase_info_data_t()
        mach_timebase_info(&info)
    }

    var isRunning: Bool {
        return synchronized(self) { () -> Bool in
            return running
        }
    }

    func start() {
        synchronized(self) { () -> Void in
            if !isRunning {
                running = true
                startTime = mach_absolute_time()
            }
        }
    }

    func reset() {
        synchronized(self) { () -> Void in
            running = false
            duration = 0
            startTime = 0
        }
    }

    @discardableResult
    func stop() -> CGFloat {
        synchronized(self) { () -> CGFloat in
            if isRunning {
                duration = read()
                running = false
            }
            return duration
        }
    }

    func read() -> CGFloat {
        synchronized(self) { () -> CGFloat in
            if isRunning {
                let endTime = mach_absolute_time()
                let elapsed = endTime - startTime
                let nanos = elapsed * UInt64(info.numer) / UInt64(info.denom)

                return duration + CGFloat(nanos) / CGFloat(NSEC_PER_SEC)
            }
            return duration
        }
    }
}

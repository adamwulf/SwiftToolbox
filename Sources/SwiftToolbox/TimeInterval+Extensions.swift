//
//  File.swift
//  
//
//  Created by Adam Wulf on 9/6/24.
//

import Foundation

public extension TimeInterval {
    init(milliseconds: UInt64) {
        self.init(Double(milliseconds) / 1000)
    }
    var milliseconds: UInt64 {
        return UInt64(self * 1000)
    }
    init(microseconds: UInt64) {
        self.init(Double(microseconds) / 1000 / 1000)
    }
    var microseconds: UInt64 {
        return UInt64(self * 1000 * 1000)
    }

    static var second: TimeInterval = 1
    static var minute: TimeInterval = 60
    static var hour: TimeInterval = 60 * minute
    static var day: TimeInterval = 24 * hour
    static var week: TimeInterval = 7 * day
    static var month: TimeInterval = 30 * day
    static var year: TimeInterval = 365 * day
}

//
//  File.swift
//  
//
//  Created by Adam Wulf on 12/11/23.
//

import Foundation

public struct SwiftToolbox {
    public enum LogLevel: Int, Comparable {
        case verbose
        case debug
        case info
        case warning
        case error

        public static func < (lhs: SwiftToolbox.LogLevel, rhs: SwiftToolbox.LogLevel) -> Bool {
            return lhs.rawValue < rhs.rawValue
        }
    }

    // swiftlint:disable line_length
    public static var logHandler: ((_ level: LogLevel, _ file: String, _ function: String, _ line: Int, _ context: [String: Any]) -> Void)?
    static func log(level: LogLevel, file: String = #file, function: String = #function, line: Int = #line, context: [String: Any]) {
        Self.logHandler?(level, file, function, line, context)
    }
    // swiftlint:enable line_length
}

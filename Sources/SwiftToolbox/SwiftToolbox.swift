//
//  File.swift
//  
//
//  Created by Adam Wulf on 12/11/23.
//

import Foundation

public struct SwiftToolbox {
    public enum LogLevel: Int {
        case verbose
        case debug
        case info
        case warning
        case error
    }

    public static var log: ((_ level: LogLevel, _ message: String, _ context: [String: Any]) -> Void)?
}

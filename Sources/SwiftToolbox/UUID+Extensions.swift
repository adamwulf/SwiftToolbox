//
//  File.swift
//  
//
//  Created by Adam Wulf on 2/5/23.
//

import Foundation

public extension UUID {
    /// Creates a simple UUID string consisting only of lowercase hex characters without `-`
    static func simpleString() -> String {
        return UUID().uuidString.lowercased().replacingOccurrences(of: "-", with: "")
    }
}

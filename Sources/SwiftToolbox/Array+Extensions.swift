//
//  File.swift
//  
//
//  Created by Adam Wulf on 6/13/22.
//

import Foundation

public extension Array where Element == UInt8 {
    var hexString: String {
        return map { String(format: "%02hhx", $0) }.joined()
    }
}
public extension Array where Element: Equatable {
    // Remove first collection element that is equal to the given `object`:
    mutating func remove(object: Element) {
        while let index = firstIndex(of: object) {
            remove(at: index)
        }
    }
}

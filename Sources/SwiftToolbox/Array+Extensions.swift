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
    /// Remove all instances of element that are equal to the given `object`:
    mutating func remove(object: Element) {
        while let index = firstIndex(of: object) {
            remove(at: index)
        }
    }
}

public extension Array {
    /// Remove element from end of array, if exists
    @inline(__always) @inlinable
    mutating func pop() -> Element? {
        guard !isEmpty else { return nil }
        return removeLast()
    }

    /// Remove element from start of array, if exists
    @inline(__always) @inlinable
    mutating func dequeue() -> Element? {
        guard !isEmpty else { return nil }
        return removeFirst()
    }
}

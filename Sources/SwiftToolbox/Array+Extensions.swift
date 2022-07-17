//
//  Array+Extensions.swift
//  
//
//  Created by Adam Wulf on 6/13/22.
//

import Foundation

public extension Array where Element == UInt8 {
    /// Converts the `UInt8` contents of the `Array` into a hex formatted `String`.
    var hexString: String {
        return map { String(format: "%02hhx", $0) }.joined()
    }
}

public extension Array where Element: Equatable {
    /// Remove all instances of element that are equal to the given `object`.
    /// - parameter object: The object to remove from the array.
    mutating func remove(object: Element) {
        while let index = firstIndex(of: object) {
            remove(at: index)
        }
    }

    func unique() -> [Element] {
        var ret: [Element] = []
        for item in self where !ret.contains(item) {
            ret.append(item)
        }
        return ret
    }
}

public extension Array {
    /// Remove element from end of array, if exists
    /// - returns: The item that was removed, or `nil` if the array is empty.
    @inline(__always) @inlinable
    mutating func pop() -> Element? {
        guard !isEmpty else { return nil }
        return removeLast()
    }

    /// Remove element from start of array, if exists
    @inline(__always) @inlinable
    /// - returns: The item that was removed, or `nil` if the array is empty.
    mutating func dequeue() -> Element? {
        guard !isEmpty else { return nil }
        return removeFirst()
    }
}

//
//  File.swift
//
//
//  Created by Adam Wulf on 2/19/23.
//

import Foundation

public extension Dictionary {
    /// Merges the input dictionary with this dictionary, preferring existing values in the case of a key conflict
    ///
    /// - Parameters:
    ///   - other: The dictionary to merge with this dictionary
    /// - Returns: A new dictionary with the merged values
    func merging(_ other: [Key: Value]) -> [Key: Value] {
        return merging(other, uniquingKeysWith: { val1, _ in
            return val1
        })
    }

    /// Returns a new dictionary with the same keys as this dictionary, but with each value transformed by the given closure.
    ///
    /// - Parameters:
    ///   - transform: A closure that takes a key-value pair of this dictionary as its argument and returns a transformed value.
    /// - Returns: A new dictionary with the same keys as this dictionary, but with each value transformed by the given closure.
    func mapValues<T>(_ transform: (Key, Value) throws -> T) rethrows -> [Key: T] {
        var result: [Key: T] = [:]
        for (key, value) in self {
            result[key] = try transform(key, value)
        }
        return result
    }

    /// Returns a new dictionary with the same values as this dictionary, but with each key transformed by the given closure.
    ///
    /// - Parameters:
    ///   - transform: A closure that takes a key-value pair of this dictionary as its argument and returns a transformed key.
    /// - Returns: A new dictionary with the same values as this dictionary, but with each key transformed by the given closure.
    func mapKeys<T: Hashable>(_ transform: (Key, Value) throws -> T) rethrows -> [T: Value] {
        var result: [T: Value] = [:]
        for (key, value) in self {
            let transformedKey = try transform(key, value)
            result[transformedKey] = value
        }
        return result
    }

    /// Returns a new dictionary with the same keys as this dictionary, but with each value that is not nil transformed by the given closure.
    ///
    /// - Parameters:
    ///   - transform: A closure that takes a key-value pair of this dictionary as its argument and returns an optional transformed value.
    /// - Returns: A new dictionary with the same keys as this dictionary, but with each value that is not nil transformed by the given closure.
    func compactMapValues<T>(_ transform: (Key, Value) throws -> T?) rethrows -> [Key: T] {
        var result: [Key: T] = [:]
        for (key, value) in self {
            if let transformedValue = try transform(key, value) {
                result[key] = transformedValue
            }
        }
        return result
    }
}

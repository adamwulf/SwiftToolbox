//
//  Sequence+Extensions.swift
//  
//
//  Created by Adam Wulf on 7/31/22.
//

import Foundation

/// An extension to the Sequence protocol to add convenience methods.
public extension Sequence {
    /// A convenience method to map a sequence and filter out `nil` values.
    /// - Parameter transform: A closure that takes an element of the sequence and its index, and returns an optional value.
    /// - Returns: An array of non-`nil` values returned by the `transform` closure.
    ///
    /// # Example Use
    ///
    /// ```
    /// let myArray = [1, 2, 3, 4, 5]
    /// let evenNumbers = myArray.compactMap { (number, index) -> Int? in
    ///     if number % 2 == 0 {
    ///         return number
    ///     }
    ///     return nil
    /// }
    /// // evenNumbers == [2, 4]
    /// ```
    func compactMap<ElementOfResult>(_ transform: (Self.Element, Int) throws -> ElementOfResult?) rethrows -> [ElementOfResult] {
        var ret: [ElementOfResult] = []
        var index = 0
        for item in self {
            if let result = try transform(item, index) {
                ret.append(result)
            }
            index += 1
        }
        return ret
    }

    /// A convenience method to map a sequence.
    /// - Parameter transform: A closure that takes an element of the sequence and its index, and returns a value.
    /// - Returns: An array of values returned by the `transform` closure.
    ///
    /// # Example Use
    ///
    /// ```
    /// let myArray = [1, 2, 3, 4, 5]
    /// let doubleNumbers = myArray.map { (number, index) -> Int in
    ///     return number * 2
    /// }
    /// // doubleNumbers == [2, 4, 6, 8, 10]
    /// ```
    func map<ElementOfResult>(_ transform: (Self.Element, Int) throws -> ElementOfResult) rethrows -> [ElementOfResult] {
        var ret: [ElementOfResult] = []
        var index = 0
        for item in self {
            ret.append(try transform(item, index))
            index += 1
        }
        return ret
    }
}

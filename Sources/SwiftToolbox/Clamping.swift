//
//  Clamping.swift
//  Inkable
//
//  Created by Adam Wulf on 9/5/20.
//

import Foundation

/// The property wrapper will clamp the value of the property to be within the `ClosedRange`
@propertyWrapper
public struct Clamped<Value: Comparable> {
    var value: Value
    let range: ClosedRange<Value>

    /// Clamps the wrapped property to the defined allowed range
    /// - parameter range: The range of allowed values for the wrapped property
    public init(wrappedValue: Value, _ range: ClosedRange<Value>) {
        precondition(range.contains(wrappedValue))
        self.value = wrappedValue
        self.range = range
    }

    /// This returns the range provided during init
    public var projectedValue: ClosedRange<Value> {
        return range
    }

    /// The clamped value of the wrapped property
    public var wrappedValue: Value {
        get { value }
        set { value = clamp(value, to: range) }
    }
}

public extension Comparable {
    /// Clamp `self` to within the input range
    /// - parameter limits: The limiting range for the clamped value
    func clamp(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}

/// Clamps the input value to within the input `limits` range
/// - parameter val: The value to clamp
/// - parameter limits: The range of allowed values for the clamped value
public func clamp<T>(_ val: T, to limits: ClosedRange<T>) -> T {
    return min(max(val, limits.lowerBound), limits.upperBound)
}

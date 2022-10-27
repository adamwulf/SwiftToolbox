//
//  Clamping.swift
//  Inkable
//
//  Created by Adam Wulf on 9/5/20.
//

import Foundation

@propertyWrapper
public struct Clamped<Value: Comparable> {
    var value: Value
    let range: ClosedRange<Value>

    public init(wrappedValue: Value, _ range: ClosedRange<Value>) {
        precondition(range.contains(wrappedValue))
        self.value = wrappedValue
        self.range = range
    }

    public var projectedValue: ClosedRange<Value> {
        return range
    }

    public var wrappedValue: Value {
        get { value }
        set { value = min(max(range.lowerBound, newValue), range.upperBound) }
    }
}

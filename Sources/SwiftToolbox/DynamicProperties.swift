//
//  DynamicProperties.swift
//  
//
//  Created by Adam Wulf on 10/26/22.
//
//  Original Author: Ian Keen
//  From: https://github.com/IanKeen/Components/blob/master/Components.playground/Sources/DynamicProperties/DynamicProperties.swift

import ObjectiveC

/// A protocol for objects that can have dynamic properties.
public protocol DynamicProperties: AnyObject {
    /// A generic subscript for getting and setting dynamic properties.
    /// - Parameters:
    ///   - key: The name of the dynamic property.
    ///   - value: The value of the dynamic property.
    subscript<T>(dynamic key: String) -> T? { get set }
}

private extension String {
    /// An unsafe pointer to the string's hash value.
    var unsafePointer: UnsafeRawPointer {
        return UnsafeRawPointer(bitPattern: hashValue)!
    }
}

extension DynamicProperties {
    /// A generic subscript for getting and setting dynamic properties.
    /// - Parameters:
    ///   - key: The name of the dynamic property.
    ///   - value: The value of the dynamic property.
    public subscript<T>(dynamic key: String) -> T? {
        get { return objc_getAssociatedObject(self, key.unsafePointer) as? T }
        set { objc_setAssociatedObject(self, key.unsafePointer, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    /// A generic subscript for getting and setting dynamic properties.
    /// If the property does not exist, the `default` value will be used.
    /// - Parameters:
    ///   - key: The name of the dynamic property.
    ///   - default: The default value of the dynamic property.
    public subscript<T>(dynamic key: String, or `default`: @autoclosure () -> T) -> T {
        if let existing: T = self[dynamic: key] {
            return existing
        } else {
            let value = `default`()
            self[dynamic: key] = value
            return value
        }
    }
}

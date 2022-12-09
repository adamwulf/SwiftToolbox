//
//  PListCompatible.swift
//  
//
//  Created by Adam Wulf on 4/14/21.
//

import Foundation
import CoreGraphics

/// An empty protocol implemented only by types that are safe to encode into a PList using `PropertyListSerialization`
///
/// The types that implement `PropertyListCompatible` are:
/// `Int`, `Int64`, `Int32`, `Int16`, `Int8`, `UInt`, `UInt64`, `UInt32`, `UInt16`, `UInt8`, `CGFloat`,
/// `Float`, `Double`, `String`, `Date`, `Data`, `NSDate`, `NSData`, `[PropertyListCompatible]`,
/// and `[String: PropertyListCompatible]`
public protocol PropertyListCompatible {
}

extension Int: PropertyListCompatible {
}

extension Int64: PropertyListCompatible {
}

extension Int32: PropertyListCompatible {
}

extension Int16: PropertyListCompatible {
}

extension Int8: PropertyListCompatible {
}

extension UInt: PropertyListCompatible {
}

extension UInt64: PropertyListCompatible {
}

extension UInt32: PropertyListCompatible {
}

extension UInt16: PropertyListCompatible {
}

extension UInt8: PropertyListCompatible {
}

extension CGFloat: PropertyListCompatible {
}

extension Float: PropertyListCompatible {
}

extension Double: PropertyListCompatible {
}

extension String: PropertyListCompatible {
}

extension Date: PropertyListCompatible {
}

extension Data: PropertyListCompatible {
}

extension NSDate: PropertyListCompatible {
}

extension NSData: PropertyListCompatible {
}

extension NSNumber: PropertyListCompatible {
}

extension NSString: PropertyListCompatible {
}

extension Array: PropertyListCompatible where Element: PropertyListCompatible {
}

extension Dictionary: PropertyListCompatible where Key == String, Value == PropertyListCompatible {

}

//
//  PListCompatible.swift
//  
//
//  Created by Adam Wulf on 4/14/21.
//

import Foundation
import CoreGraphics

/// An empty protocol implemented only by types that are safe to encode into a PList using `PropertyListSerialization`
public protocol PropertyListCompatible {
}

extension Int: PropertyListCompatible {
}

extension Int64: PropertyListCompatible {
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

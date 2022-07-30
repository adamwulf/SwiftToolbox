//
//  PListCompatible.swift
//  
//
//  Created by Adam Wulf on 4/14/21.
//

import Foundation
import CoreGraphics

public protocol PListCompatible {
}

extension Int: PListCompatible {
}

extension CGFloat: PListCompatible {
}

extension Float: PListCompatible {
}

extension Double: PListCompatible {
}

extension String: PListCompatible {
}

extension Date: PListCompatible {
}

extension Array: PListCompatible where Element: PListCompatible {
}

extension Dictionary: PListCompatible where Key == String, Value == PListCompatible {

}

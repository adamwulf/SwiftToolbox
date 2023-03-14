//
//  CGFloat+Extensions.swift
//
//
//  Created by Adam Wulf on 9/11/22.
//

import Foundation
import CoreGraphics

public extension CGFloat {
    /// Returns the square of the receiver.
    /// - returns: The square of the receiver.
    func squared() -> CGFloat {
        return self * self
    }

    /// Returns the cube of the receiver.
    /// - returns: The cube of the receiver.
    func cubed() -> CGFloat {
        return self * self * self
    }

    /// Returns the receiver raised to the given power.
    /// - parameter power: The power to raise the receiver to.
    /// - returns: The receiver raised to the given power.
    func pow(_ power: Int) -> CGFloat {
        var ret = self
        for _ in 1..<power {
            ret *= self
        }
        return ret
    }

    /// Returns the absolute value of the receiver.
    /// - returns: The absolute value of the receiver.
    func abs() -> CGFloat {
        return Swift.abs(self)
    }

    /// Returns the square root of the receiver.
    /// - returns: The square root of the receiver, or `nil` if the receiver is negative.
    func sqrt() -> CGFloat? {
        return self >= 0 ? CoreGraphics.sqrt(self) : nil
    }

    /// Returns the receiver rounded to the nearest integer.
    /// - returns: The receiver rounded to the nearest integer.
    func round() -> CGFloat {
        return CoreGraphics.round(self)
    }

    /// Returns the receiver rounded up to the nearest integer.
    /// - returns: The receiver rounded up to the nearest integer.
    func ceil() -> CGFloat {
        return CoreGraphics.ceil(self)
    }

    /// Returns the receiver rounded down to the nearest integer.
    /// - returns: The receiver rounded down to the nearest integer.
    func floor() -> CGFloat {
        return CoreGraphics.floor(self)
    }
}

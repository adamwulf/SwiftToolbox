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
}

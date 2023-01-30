//
//  CGAffineTransform+Extensions.swift
//
//
//  Created by Adam Wulf on 7/30/22.
//

import CoreGraphics

public extension CGAffineTransform {

    /// The scale of the transform.
    /// - returns: The scale of the transform.
    var scale: CGPoint {
        return CGPoint(x: sqrt(a * a + c * c), y: sqrt(b * b + d * d))
    }

    /// The translation of the transform.
    /// - returns: The translation of the transform.
    var translation: CGPoint {
        return CGPoint(x: tx, y: ty)
    }

    /// The rotation of the transform.
    /// - returns: The rotation of the transform.
    var rotation: CGFloat {
        return atan2(b, a)
    }

    /// Returns a new transform that is translated by the given point.
    /// - parameter point: The point to translate by.
    /// - returns: A new transform that is translated by the given point.
    func translated(by point: CGPoint) -> CGAffineTransform {
        return translatedBy(x: point.x, y: point.y)
    }

    /// Returns a new transform that is translated by the given vector.
    /// - parameter vector: The vector to translate by.
    /// - returns: A new transform that is translated by the given vector.
    func translated(by vector: CGVector) -> CGAffineTransform {
        return translatedBy(x: vector.dx, y: vector.dy)
    }

    /// Returns a new transform that is scaled by the given scale.
    /// - parameter scale: The scale to scale by.
    /// - returns: A new transform that is scaled by the given scale.
    func scaled(by scale: CGFloat) -> CGAffineTransform {
        return scaledBy(x: scale, y: scale)
    }
}

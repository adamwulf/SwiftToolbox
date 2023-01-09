//
//  CGVector+Extensions.swift
//  
//
//  Created by Adam Wulf on 4/11/21.
//
// swiftlint:disable shorthand_operator

import CoreGraphics

infix operator ⋅ : MultiplicationPrecedence
extension CGVector {

    // MARK: - Initialization

    /// Initializes the CGVector object with the given x and y values.
    public init(_ dx: CGFloat, _ dy: CGFloat) {
        self.init(dx: dx, dy: dy)
    }

    /// Initializes the CGVector from an angle, in radians.
    public init(theta: CGFloat) {
        self.init(dx: cos(theta), dy: sin(theta))
    }

    // MARK: - Min / Max

    /// Returns the minimum of the x and y values.
    public var min: CGFloat {
        return Swift.min(dx, dy)
    }

    /// Returns the maximum of the x and y values.
    public var max: CGFloat {
        return Swift.max(dx, dy)
    }

    // MARK: - Vectors

    /// Returns the unit vector of the current vector.
    public var unitVector: CGVector {
        return scale(toLength: 1)
    }

    /// Returns the magnitude of the vector.
    public var magnitude: CGFloat {
        return sqrt(dx * dx + dy * dy)
    }

    /// Returns the angle of the vector in radians.
    public var theta: CGFloat {
        // divide by zero is fine here, as atan handles ±inf properly
        var theta = atan(dy / dx)
        let isYNeg = dy < 0
        let isXNeg = dx < 0

        // adjust the angle depending on which quadrant it's in
        if isYNeg && isXNeg {
            theta -= CGFloat.pi
        } else if !isYNeg && isXNeg {
            theta += CGFloat.pi
        }
        return theta
    }

    /// Scales the vector to the desired length.
    /// - Parameter target: The desired length.
    public func scale(toLength target: CGFloat) -> CGVector {
        let len = magnitude
        return CGVector(dx: dx / len * target, dy: dy / len * target)
    }

    /// Returns the normal of the vector.
    public var normal: CGVector {
        return CGVector(dx: -self.dy, dy: self.dx)
    }

    // MARK: - Prefixes

    /// Negates the vector.
    static prefix public func - (vec: CGVector) -> CGVector {
        return CGVector(-vec.dx, -vec.dy)
    }

    // MARK: - Dot Product

    /// Performs a dot product with another vector.
    /// - Parameter other: The vector to dot with.
    public func dot(_ other: CGVector) -> CGFloat {
        return dx * other.dx + dy * other.dy
    }

    /// Performs a dot product with two vectors.
    static public func ⋅ (lhs: CGVector, rhs: CGVector) -> CGFloat {
        return lhs.dot(rhs)
    }

    // MARK: - Assignment Operators

    /// Adds the right-hand side vector to the left-hand side.
    static public func += (lhs: inout CGVector, rhs: CGVector) {
        lhs = lhs + rhs
    }

    /// Subtracts the right-hand side vector from the left-hand side.
    static public func -= (lhs: inout CGVector, rhs: CGVector) {
        lhs = lhs - rhs
    }

    // MARK: - Translate

    /// Adds the two vectors together.
    static public func + (lhs: CGVector, rhs: CGVector) -> CGVector {
        return CGVector(dx: lhs.dx + rhs.dx, dy: lhs.dy + rhs.dy)
    }

    /// Subtracts the right-hand side vector from the left-hand side.
    static public func - (lhs: CGVector, rhs: CGVector) -> CGVector {
        return CGVector(dx: lhs.dx - rhs.dx, dy: lhs.dy - rhs.dy)
    }

    // MARK: - Scale

    /// Scales the vector by the given integer.
    static public func * (lhs: CGVector, rhs: Int) -> CGVector {
        return CGVector(dx: lhs.dx * CGFloat(rhs), dy: lhs.dy * CGFloat(rhs))
    }

    /// Divides the vector by the given integer.
    static public func / (lhs: CGVector, rhs: Int) -> CGVector {
        return CGVector(dx: lhs.dx / CGFloat(rhs), dy: lhs.dy / CGFloat(rhs))
    }

    /// Scales the vector by the given float.
    static public func * (lhs: CGVector, rhs: CGFloat) -> CGVector {
        return CGVector(dx: lhs.dx * rhs, dy: lhs.dy * rhs)
    }

    /// Divides the vector by the given float.
    static public func / (lhs: CGVector, rhs: CGFloat) -> CGVector {
        return CGVector(dx: lhs.dx / rhs, dy: lhs.dy / rhs)
    }

    /// Scales the vector by the given integer.
    static public func * (lhs: Int, rhs: CGVector) -> CGVector {
        return CGVector(dx: rhs.dx * CGFloat(lhs), dy: rhs.dy * CGFloat(lhs))
    }

    /// Scales the vector by the given float.
    static public func * (lhs: CGFloat, rhs: CGVector) -> CGVector {
        return CGVector(dx: rhs.dx * lhs, dy: rhs.dy * lhs)
    }
}

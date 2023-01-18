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

    /// Initializes a `CGVector` with the given `dx` and `dy` components.
    /// - Parameters:
    ///   - dx: The x component of the vector.
    ///   - dy: The y component of the vector.
    public init(_ dx: CGFloat, _ dy: CGFloat) {
        self.init(dx: dx, dy: dy)
    }

    /// Initializes a `CGVector` with the given `theta` angle.
    /// - Parameter theta: The angle of the vector in radians.
    public init(theta: CGFloat) {
        self.init(dx: cos(theta), dy: sin(theta))
    }

    // MARK: - Min / Max

    /// The minimum component of the vector.
    public var min: CGFloat {
        return Swift.min(dx, dy)
    }

    /// The maximum component of the vector.
    public var max: CGFloat {
        return Swift.max(dx, dy)
    }

    // MARK: - Vectors

    /// The unit vector of the vector.
    public var unitVector: CGVector {
        return scale(toLength: 1)
    }

    /// The magnitude of the vector.
    public var magnitude: CGFloat {
        return sqrt(dx * dx + dy * dy)
    }

    /// The angle of the vector in radians.
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

    /// Scales the vector to the given `target` length.
    /// - Parameter target: The target length of the vector.
    /// - Returns: The scaled vector.
    public func scale(toLength target: CGFloat) -> CGVector {
        let len = magnitude
        return CGVector(dx: dx / len * target, dy: dy / len * target)
    }

    /// The normal vector of the vector.
    public var normal: CGVector {
        return CGVector(dx: -self.dy, dy: self.dx)
    }
    // MARK: - Prefixes

    /// Negates the vector.
    static prefix public func - (vec: CGVector) -> CGVector {
        return CGVector(-vec.dx, -vec.dy)
    }

    // MARK: - Dot Product

    /// Calculates the dot product of two vectors.
    /// - Parameter other: The other vector to calculate the dot product with.
    /// - Returns: The dot product of the two vectors.
    public func dot(_ other: CGVector) -> CGFloat {
        return dx * other.dx + dy * other.dy
    }

    /// Calculates the dot product of two vectors.
    /// - Parameters:
    ///   - lhs: The first vector.
    ///   - rhs: The second vector.
    /// - Returns: The dot product of the two vectors.
    static public func ⋅ (lhs: CGVector, rhs: CGVector) -> CGFloat {
        return lhs.dot(rhs)
    }

    // MARK: - Assignment Operators

    /// Adds the right-hand vector to the left-hand vector.
    static public func += (lhs: inout CGVector, rhs: CGVector) {
        lhs = lhs + rhs
    }

    /// Subtracts the right-hand vector from the left-hand vector.
    static public func -= (lhs: inout CGVector, rhs: CGVector) {
        lhs = lhs - rhs
    }

    // MARK: - Translate

    /// Adds two vectors together.
    /// - Parameters:
    ///   - lhs: The first vector.
    ///   - rhs: The second vector.
    /// - Returns: The sum of the two vectors.
    static public func + (lhs: CGVector, rhs: CGVector) -> CGVector {
        return CGVector(dx: lhs.dx + rhs.dx, dy: lhs.dy + rhs.dy)
    }

    /// Subtracts two vectors.
    /// - Parameters:
    ///   - lhs: The first vector.
    ///   - rhs: The second vector.
    /// - Returns: The difference of the two vectors.
    static public func - (lhs: CGVector, rhs: CGVector) -> CGVector {
        return CGVector(dx: lhs.dx - rhs.dx, dy: lhs.dy - rhs.dy)
    }

    // MARK: - Scale

    /// Scales the vector by an integer.
    /// - Parameters:
    ///   - lhs: The vector.
    ///   - rhs: The integer.
    /// - Returns: The vector scaled by the integer.
    static public func * (lhs: CGVector, rhs: Int) -> CGVector {
        return CGVector(dx: lhs.dx * CGFloat(rhs), dy: lhs.dy * CGFloat(rhs))
    }

    /// Scales the vector down by an integer.
    /// - Parameters:
    ///   - lhs: The vector.
    ///   - rhs: The integer.
    /// - Returns: The vector scaled down by the integer.
    static public func / (lhs: CGVector, rhs: Int) -> CGVector {
        return CGVector(dx: lhs.dx / CGFloat(rhs), dy: lhs.dy / CGFloat(rhs))
    }

    /// Scales the vector by a CGFloat.
    /// - Parameters:
    ///   - lhs: The vector.
    ///   - rhs: The CGFloat.
    /// - Returns: The vector scaled by the CGFloat.
    static public func * (lhs: CGVector, rhs: CGFloat) -> CGVector {
        return CGVector(dx: lhs.dx * rhs, dy: lhs.dy * rhs)
    }

    /// Scales the vector down by a CGFloat.
    /// - Parameters:
    ///   - lhs: The vector.
    ///   - rhs: The CGFloat.
    /// - Returns: The vector scaled down by the CGFloat.
    static public func / (lhs: CGVector, rhs: CGFloat) -> CGVector {
        return CGVector(dx: lhs.dx / rhs, dy: lhs.dy / rhs)
    }

    /// Scales an integer by a vector.
    /// - Parameters:
    ///   - lhs: The integer.
    ///   - rhs: The vector.
    /// - Returns: The vector scaled by the integer.
    static public func * (lhs: Int, rhs: CGVector) -> CGVector {
        return CGVector(dx: rhs.dx * CGFloat(lhs), dy: rhs.dy * CGFloat(lhs))
    }

    /// Scales a CGFloat by a vector.
    /// - Parameters:
    ///   - lhs: The CGFloat.
    ///   - rhs: The vector.
    /// - Returns: The vector scaled by the CGFloat.
    static public func * (lhs: CGFloat, rhs: CGVector) -> CGVector {
        return CGVector(dx: rhs.dx * lhs, dy: rhs.dy * lhs)
    }
}

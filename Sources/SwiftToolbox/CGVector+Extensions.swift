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
    public init(_ dx: CGFloat, _ dy: CGFloat) {
        self.init(dx: dx, dy: dy)
    }

    // MARK: - Min / Max

    public var min: CGFloat {
        return Swift.min(dx, dy)
    }

    public var max: CGFloat {
        return Swift.max(dx, dy)
    }

    // MARK: - Vectors

    public var normalized: CGVector {
        return normalize()
    }

    public var magnitude: CGFloat {
        return sqrt(dx * dx + dy * dy)
    }

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

    public init(theta: CGFloat) {
        self.init(dx: cos(theta), dy: sin(theta))
    }

    public func normalize(to target: CGFloat = 1) -> CGVector {
        let len = magnitude
        return CGVector(dx: dx / len * target, dy: dy / len * target)
    }

    // MARK: - Prefixes

    static prefix public func - (vec: CGVector) -> CGVector {
        return CGVector(-vec.dx, -vec.dy)
    }

    // MARK: - Dot Product

    public func dot(_ other: CGVector) -> CGFloat {
        return dx * other.dx + dy * other.dy
    }

    static public func ⋅ (lhs: CGVector, rhs: CGVector) -> CGFloat {
        return lhs.dot(rhs)
    }

    // MARK: - Assignment Operators

    static public func += (lhs: inout CGVector, rhs: CGVector) {
        lhs = lhs + rhs
    }

    static public func -= (lhs: inout CGVector, rhs: CGVector) {
        lhs = lhs - rhs
    }

    // MARK: - Translate

    static public func + (lhs: CGVector, rhs: CGVector) -> CGVector {
        return CGVector(dx: lhs.dx + rhs.dx, dy: lhs.dy + rhs.dy)
    }

    static public func - (lhs: CGVector, rhs: CGVector) -> CGVector {
        return CGVector(dx: lhs.dx - rhs.dx, dy: lhs.dy - rhs.dy)
    }

    // MARK: - Scale

    static public func * (lhs: CGVector, rhs: Int) -> CGVector {
        return CGVector(dx: lhs.dx * CGFloat(rhs), dy: lhs.dy * CGFloat(rhs))
    }

    static public func / (lhs: CGVector, rhs: Int) -> CGVector {
        return CGVector(dx: lhs.dx / CGFloat(rhs), dy: lhs.dy / CGFloat(rhs))
    }

    static public func * (lhs: CGVector, rhs: CGFloat) -> CGVector {
        return CGVector(dx: lhs.dx * rhs, dy: lhs.dy * rhs)
    }

    static public func / (lhs: CGVector, rhs: CGFloat) -> CGVector {
        return CGVector(dx: lhs.dx / rhs, dy: lhs.dy / rhs)
    }

    static public func * (lhs: Int, rhs: CGVector) -> CGVector {
        return CGVector(dx: rhs.dx * CGFloat(lhs), dy: rhs.dy * CGFloat(lhs))
    }

    static public func * (lhs: CGFloat, rhs: CGVector) -> CGVector {
        return CGVector(dx: rhs.dx * lhs, dy: rhs.dy * lhs)
    }
}

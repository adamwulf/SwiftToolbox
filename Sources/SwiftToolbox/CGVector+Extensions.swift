//
//  CGVector+Extensions.swift
//  
//
//  Created by Adam Wulf on 4/11/21.
//

import CoreGraphics

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

    /// Initializes a new vector from a start point to an end point.
    public init(start: CGPoint, end: CGPoint) {
        self.init(dx: end.x - start.x, dy: end.y - start.y)
    }

    // MARK: - Flip

    public mutating func flip() {
        self.dx = -self.dx
        self.dy = -self.dy
    }

    public func flipped() -> CGVector {
        return CGVector(dx: -self.dx, dy: -self.dy)
    }

    // MARK: - Min / Max

    /// The minimum component of the vector.
    public var minDim: CGFloat {
        return min(dx, dy)
    }

    /// The maximum component of the vector.
    public var maxDim: CGFloat {
        return max(dx, dy)
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

    /// Calculates the angle between this vector and another vector.
    ///
    /// The angle is measured in radians, in the range (-π, π].
    ///
    /// - Parameter otherVector: The other vector to measure the angle against.
    /// - Returns: The angle between the two vectors, in radians.
    public func angleBetween(_ otherVector: CGVector) -> CGFloat {
        let thetaA = atan2(otherVector.dx, otherVector.dy)
        let thetaB = atan2(self.dx, self.dy)

        var thetaAB = thetaB - thetaA

        while thetaAB <= -CGFloat.pi {
            thetaAB += 2 * CGFloat.pi
        }

        while thetaAB > CGFloat.pi {
            thetaAB -= 2 * CGFloat.pi
        }

        return thetaAB
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
}

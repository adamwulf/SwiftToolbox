//
//  File.swift
//  
//
//  Created by Adam Wulf on 6/18/24.
//

import CoreGraphics

extension CGPoint {
    // MARK: - Prefix

    /// Negates the coordinates of a `CGPoint`
    ///
    /// - Parameter rhs: The `CGPoint` to negate
    /// - Returns: A new `CGPoint` with the negated coordinates
    static public prefix func - (rhs: CGPoint) -> CGPoint {
        return CGPoint(x: -rhs.x, y: -rhs.y)
    }

    // MARK: - Compute Vector

    /// Computes the difference between two `CGPoint`s
    ///
    /// - Parameters:
    ///   - lhs: The first `CGPoint`
    ///   - rhs: The second `CGPoint`
    /// - Returns: A `CGVector` representing the difference between the two `CGPoint`s
    static public func - (lhs: CGPoint, rhs: CGPoint) -> CGVector {
        return CGVector(dx: lhs.x - rhs.x, dy: lhs.y - rhs.y)
    }

    // MARK: - Assignment Operators

    /// Assigns a `CGVector` to a `CGPoint`
    ///
    /// - Parameters:
    ///   - lhs: The `CGPoint` to assign to
    ///   - rhs: The `CGVector` to assign
    static public func += (lhs: inout CGPoint, rhs: CGVector) {
        lhs = lhs + rhs
    }

    /// Subtracts a `CGVector` from a `CGPoint`
    ///
    /// - Parameters:
    ///   - lhs: The `CGPoint` to subtract from
    ///   - rhs: The `CGVector` to subtract
    static public func -= (lhs: inout CGPoint, rhs: CGVector) {
        lhs = lhs - rhs
    }

    // MARK: - Translate

    /// Translates a `CGPoint` by another `CGPoint`
    ///
    /// - Parameters:
    ///   - lhs: The `CGPoint` to translate
    ///   - rhs: The `CGPoint` to translate by
    /// - Returns: A new `CGPoint` with the translated coordinates
    static public func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }

    /// Translates a `CGPoint` by a `CGVector`
    ///
    /// - Parameters:
    ///   - lhs: The `CGPoint` to translate
    ///   - rhs: The `CGVector` to translate by
    /// - Returns: A new `CGPoint` with the translated coordinates
    static public func + (lhs: CGPoint, rhs: CGVector) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.dx, y: lhs.y + rhs.dy)
    }

    /// Subtracts a `CGVector` from a `CGPoint`
    ///
    /// - Parameters:
    ///   - lhs: The `CGPoint` to subtract from
    ///   - rhs: The `CGVector` to subtract
    /// - Returns: A new `CGPoint` with the translated coordinates
    static public func - (lhs: CGPoint, rhs: CGVector) -> CGPoint {
        return CGPoint(x: lhs.x - rhs.dx, y: lhs.y - rhs.dy)
    }

    /// Translates a `CGPoint` by a `CGSize`
    ///
    /// - Parameters:
    ///   - lhs: The `CGPoint` to translate
    ///   - rhs: The `CGSize` to translate by
    /// - Returns: A new `CGPoint` with the translated coordinates
    static public func + (lhs: CGPoint, rhs: CGSize) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.width, y: lhs.y + rhs.height)
    }

    /// Subtracts a `CGSize` from a `CGPoint`
    ///
    /// - Parameters:
    ///   - lhs: The `CGPoint` to subtract from
    ///   - rhs: The `CGSize` to subtract
    /// - Returns: A new `CGPoint` with the translated coordinates
    static public func - (lhs: CGPoint, rhs: CGSize) -> CGPoint {
        return CGPoint(x: lhs.x - rhs.width, y: lhs.y - rhs.height)
    }

    // Reversed lhs/rhs

    /// Translates a `CGPoint` by a `CGVector`
    ///
    /// - Parameters:
    ///   - lhs: The `CGVector` to translate by
    ///   - rhs: The `CGPoint` to translate
    /// - Returns: A new `CGPoint` with the translated coordinates
    static public func + (lhs: CGVector, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.dx + rhs.x, y: lhs.dy + rhs.y)
    }

    // MARK: - Scale

    /// Scales a CGPoint by an Int
    /// - Parameters:
    ///   - lhs: The CGPoint to be scaled
    ///   - rhs: The Int to scale by
    /// - Returns: A CGPoint scaled by the Int
    static public func * (lhs: CGPoint, rhs: Int) -> CGPoint {
        return CGPoint(x: lhs.x * CGFloat(rhs), y: lhs.y * CGFloat(rhs))
    }

    /// Scales a CGPoint by an Int
    /// - Parameters:
    ///   - lhs: The CGPoint to be scaled
    ///   - rhs: The Int to scale by
    /// - Returns: A CGPoint scaled by the Int
    static public func / (lhs: CGPoint, rhs: Int) -> CGPoint {
        return CGPoint(x: lhs.x / CGFloat(rhs), y: lhs.y / CGFloat(rhs))
    }

    /// Scales a CGPoint by a CGFloat
    /// - Parameters:
    ///   - lhs: The CGPoint to be scaled
    ///   - rhs: The CGFloat to scale by
    /// - Returns: A CGPoint scaled by the CGFloat
    static public func * (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        return CGPoint(x: lhs.x * rhs, y: lhs.y * rhs)
    }

    /// Scales a CGPoint by a CGFloat
    /// - Parameters:
    ///   - lhs: The CGPoint to be scaled
    ///   - rhs: The CGFloat to scale by
    /// - Returns: A CGPoint scaled by the CGFloat
    static public func / (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        return CGPoint(x: lhs.x / rhs, y: lhs.y / rhs)
    }

    // Reversed lhs/rhs

    /// Scales a CGPoint by an Int
    /// - Parameters:
    ///   - lhs: The Int to scale by
    ///   - rhs: The CGPoint to be scaled
    /// - Returns: A CGPoint scaled by the Int
    static func * (lhs: Int, rhs: CGPoint) -> CGPoint {
        return rhs * CGFloat(lhs)
    }

    /// Scales a CGPoint by an Int
    /// - Parameters:
    ///   - lhs: The Int to scale by
    ///   - rhs: The CGPoint to be scaled
    /// - Returns: A CGPoint scaled by the Int
    static func / (lhs: Int, rhs: CGPoint) -> CGPoint {
        return CGFloat(lhs) / rhs
    }

    /// Scales a CGPoint by a CGFloat
    /// - Parameters:
    ///   - lhs: The CGFloat to scale by
    ///   - rhs: The CGPoint to be scaled
    /// - Returns: A CGPoint scaled by the CGFloat
    static func * (lhs: CGFloat, rhs: CGPoint) -> CGPoint {
        return rhs * lhs
    }

    /// Scales a CGPoint by a CGFloat
    /// - Parameters:
    ///   - lhs: The CGFloat to scale by
    ///   - rhs: The CGPoint to be scaled
    /// - Returns: A CGPoint scaled by the CGFloat
    static func / (lhs: CGFloat, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs / rhs.x, y: lhs / rhs.y)
    }
}

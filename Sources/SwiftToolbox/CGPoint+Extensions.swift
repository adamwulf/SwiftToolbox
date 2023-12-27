//
//  CGPoint+Extensions.swift
//  
//
//  Created by Adam Wulf on 4/11/21.
//

import CoreGraphics

extension CGPoint {
    /// Initializes a CGPoint with two CGFloat values
    /// - Parameter x: The x coordinate of the point
    /// - Parameter y: The y coordinate of the point
    public init(_ x: CGFloat, _ y: CGFloat) {
        self.init(x: x, y: y)
    }

    /// Initializes a CGPoint with two Double values
    /// - Parameter x: The x coordinate of the point
    /// - Parameter y: The y coordinate of the point
    public init(_ x: Double, _ y: Double) {
        self.init(x: x, y: y)
    }

    /// Initializes a CGPoint with two Int values
    /// - Parameter x: The x coordinate of the point
    /// - Parameter y: The y coordinate of the point
    public init(_ x: Int, _ y: Int) {
        self.init(x: x, y: y)
    }

    /// Calculates the distance between two points
    /// - Parameter point: The point to calculate the distance to
    /// - Returns: The distance between the two points
    public func distance(to point: CGPoint) -> CGFloat {
        let x2 = (point.x - x) * (point.x - x)
        let y2 = (point.y - y) * (point.y - y)
        return sqrt(x2 + y2)
    }

    /// Calculates the distance between a point and a line
    /// - Parameter line: The line to calculate the distance to
    /// - Returns: The distance between the point and the line
    public func distance(to line: CGLine) -> CGFloat {
        let p0 = line.p0
        let p1 = line.p1
        let lineDiff = p1 - p0
        let pointDiff = p0 - self
        let num = abs(lineDiff.dx * pointDiff.dy - pointDiff.dx * lineDiff.dy)
        let den = sqrt(lineDiff.dx * lineDiff.dx + lineDiff.dy * lineDiff.dy)
        return num / den
    }

    /// Calculates the distance between a point and a segment
    /// - Parameter segment: The segment to calculate the distance to
    /// - Returns: The distance between the point and the segment
    public func distance(to segment: CGSegment) -> CGFloat {
        let close = closestPoint(to: segment)
        return distance(to: close)
    }

    /// Calculates the closest point on a line to the point
    /// - Parameter line: The line to calculate the closest point on
    /// - Returns: The closest point on the line to the point
    public func closestPoint(to line: CGLine) -> CGPoint {
        let p0 = line.p0
        let p1 = line.p1
        let direction = (p1 - p0).unitVector
        let lhs = self - p0
        let dot = lhs.dot(direction)
        return p0 + direction * dot
    }

    /// Calculates the closest point on a segment to the point
    /// - Parameter segment: The segment to calculate the closest point on
    /// - Returns: The closest point on the segment to the point
    public func closestPoint(to segment: CGSegment) -> CGPoint {
        let p0 = segment.start
        let p1 = segment.end
        let direction = (p1 - p0).unitVector
        let lhs = self - p0
        let length = p0.distance(to: p1)
        let dot = Swift.min(length, Swift.max(0, lhs.dot(direction)))
        return p0 + direction * dot
    }

    /// Converts the point to a CGVector
    /// - Returns: The point as a CGVector
    public var asVector: CGVector {
        return CGVector(dx: x, dy: y)
    }

    /// Calculates the minimum of the x and y coordinates
    /// - Returns: The minimum of the x and y coordinates
    public var minDim: CGFloat {
        return Swift.min(x, y)
    }

    /// Calculates the maximum of the x and y coordinates
    /// - Returns: The maximum of the x and y coordinates
    public var maxDim: CGFloat {
        return Swift.max(x, y)
    }

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

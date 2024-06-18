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
        let dot = min(length, max(0, lhs.dot(direction)))
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
        return min(x, y)
    }

    /// Calculates the maximum of the x and y coordinates
    /// - Returns: The maximum of the x and y coordinates
    public var maxDim: CGFloat {
        return max(x, y)
    }
}

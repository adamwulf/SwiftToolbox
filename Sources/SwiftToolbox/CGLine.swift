//
//  CGLine.swift
//
//
//  Created by Adam Wulf on 9/6/22.
//

import Foundation
import CoreGraphics

/// Represents an infinite line through `p0` and `p1`
public struct CGLine {
    /// The first endpoint of the line.
    public var p0: CGPoint
    /// The second endpoint of the line.
    public var p1: CGPoint

    /// Create a new `CGLine` from two endpoints
    public init(_ p0: CGPoint, _ p1: CGPoint) {
        self.p0 = p0
        self.p1 = p1
    }

    /// Create a new `CGLine` from two endpoints
    public init(p0: CGPoint, p1: CGPoint) {
        self.p0 = p0
        self.p1 = p1
    }

    /// The length of the line.
    public var length: CGFloat {
        return (p1 - p0).magnitude
    }

    /// Returns the distance from the line to the given point.
    /// - parameter point: The point to measure the distance to.
    /// - returns: The distance from the line to the given point.
    public func distanceToPoint(point: CGPoint) -> CGFloat {
        let normal = (p1 - p0).normal
        return (point - p0).dot(normal)
    }
}

/// Represents an line segment from `start` to `end`
public struct CGSegment {
    /// The start of the line segment.
    public var start: CGPoint
    /// The end of the line segment.
    public var end: CGPoint

    /// Create a new `CGSegment` from two endpoints
    public init(_ start: CGPoint, _ end: CGPoint) {
        self.start = start
        self.end = end
    }

    /// Create a new `CGSegment` from two endpoints
    public init(start: CGPoint, end: CGPoint) {
        self.start = start
        self.end = end
    }
}

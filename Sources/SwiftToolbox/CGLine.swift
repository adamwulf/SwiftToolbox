//
//  File.swift
//  
//
//  Created by Adam Wulf on 9/6/22.
//

import Foundation
import CoreGraphics

/// Represents an infinite line through `p0` and `p1`
public struct CGLine {
    public var p0: CGPoint
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
}

/// Represents an line segment from `start` to `end`
public struct CGSegment {
    public var start: CGPoint
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

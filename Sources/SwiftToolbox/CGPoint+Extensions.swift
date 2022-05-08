//
//  File.swift
//  
//
//  Created by Adam Wulf on 4/11/21.
//

import CoreGraphics

extension CGPoint {
    public init(_ x: CGFloat, _ y: CGFloat) {
        self.init(x: x, y: y)
    }

    public init(_ x: Double, _ y: Double) {
        self.init(x: x, y: y)
    }

    public init(_ x: Int, _ y: Int) {
        self.init(x: x, y: y)
    }

    public func distance(to point: CGPoint) -> CGFloat {
        let x2 = (point.x - x) * (point.x - x)
        let y2 = (point.y - y) * (point.y - y)
        return sqrt(x2 + y2)
    }

    // MARK: - Translate

    static public func - (lhs: CGPoint, rhs: CGPoint) -> CGVector {
        return CGVector(dx: lhs.x - rhs.x, dy: lhs.y - rhs.y)
    }

    static public func + (lhs: CGPoint, rhs: CGPoint) -> CGVector {
        return CGVector(dx: lhs.x + rhs.x, dy: lhs.y + rhs.y)
    }

    static public func + (lhs: CGPoint, rhs: CGVector) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.dx, y: lhs.y + rhs.dy)
    }

    static public func - (lhs: CGPoint, rhs: CGVector) -> CGPoint {
        return CGPoint(x: lhs.x - rhs.dx, y: lhs.y - rhs.dy)
    }

    static public func + (lhs: CGPoint, rhs: CGSize) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.width, y: lhs.y + rhs.height)
    }

    static public func - (lhs: CGPoint, rhs: CGSize) -> CGPoint {
        return CGPoint(x: lhs.x - rhs.width, y: lhs.y - rhs.height)
    }

    // MARK: - Min / Max

    public var min: CGFloat {
        return Swift.min(x, y)
    }

    public var max: CGFloat {
        return Swift.max(x, y)
    }

    // MARK: - Scale

    static public func * (lhs: CGPoint, rhs: Int) -> CGPoint {
        return CGPoint(x: lhs.x * CGFloat(rhs), y: lhs.y * CGFloat(rhs))
    }

    static public func / (lhs: CGPoint, rhs: Int) -> CGPoint {
        return CGPoint(x: lhs.x / CGFloat(rhs), y: lhs.y / CGFloat(rhs))
    }

    static public func * (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        return CGPoint(x: lhs.x * rhs, y: lhs.y * rhs)
    }

    static public func / (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        return CGPoint(x: lhs.x / rhs, y: lhs.y / rhs)
    }
}

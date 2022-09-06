//
//  CGPoint+Extensions.swift
//  
//
//  Created by Adam Wulf on 4/11/21.
//
// swiftlint:disable shorthand_operator

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

    public func distanceToLine(through p1: CGPoint, and p2: CGPoint) -> CGFloat {
        let lineDiff = p2 - p1
        let pointDiff = p1 - self
        let num = abs(lineDiff.dx * pointDiff.dy - pointDiff.dx * lineDiff.dy)
        let den = sqrt(lineDiff.dx * lineDiff.dx + lineDiff.dy * lineDiff.dy)
        return num / den
    }

    // MARK: - Convert

    public var asVector: CGVector {
        return CGVector(dx: x, dy: y)
    }

    // MARK: - Min / Max

    public var min: CGFloat {
        return Swift.min(x, y)
    }

    public var max: CGFloat {
        return Swift.max(x, y)
    }

    // MARK: - Prefix

    static public prefix func - (rhs: CGPoint) -> CGPoint {
        return CGPoint(x: -rhs.x, y: -rhs.y)
    }

    // MARK: - Compute Vector

    static public func - (lhs: CGPoint, rhs: CGPoint) -> CGVector {
        return CGVector(dx: lhs.x - rhs.x, dy: lhs.y - rhs.y)
    }

    // MARK: - Assignment Operators

    static public func += (lhs: inout CGPoint, rhs: CGVector) {
        lhs = lhs + rhs
    }

    static public func -= (lhs: inout CGPoint, rhs: CGVector) {
        lhs = lhs - rhs
    }

    // MARK: - Translate

    static public func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
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

    // Reversed lhs/rhs

    static public func + (lhs: CGVector, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.dx + rhs.x, y: lhs.dy + rhs.y)
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

    // Reversed lhs/rhs

    static func * (lhs: Int, rhs: CGPoint) -> CGPoint {
        return rhs * CGFloat(lhs)
    }

    static func / (lhs: Int, rhs: CGPoint) -> CGPoint {
        return CGFloat(lhs) / rhs
    }

    static func * (lhs: CGFloat, rhs: CGPoint) -> CGPoint {
        return rhs * lhs
    }

    static func / (lhs: CGFloat, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs / rhs.x, y: lhs / rhs.y)
    }
}

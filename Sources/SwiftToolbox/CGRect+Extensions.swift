//
//  CGRect+Extensions.swift
//  
//
//  Created by Adam Wulf on 3/14/21.
//

import CoreGraphics

extension CGRect {
    public init(_ origin: CGPoint, _ size: CGSize) {
        self.init(origin: origin, size: size)
    }

    public init(_ size: CGSize) {
        self.init(.zero, size)
    }

    public func inset(by delta: CGFloat) -> CGRect {
        return insetBy(dx: delta, dy: delta)
    }

    public func expand(by delta: CGFloat) -> CGRect {
        return inset(by: -delta)
    }

    // MARK: - Assignment Operators

    static public func += (lhs: inout CGRect, rhs: CGVector) {
        lhs = lhs + rhs
    }

    static public func -= (lhs: inout CGRect, rhs: CGVector) {
        lhs = lhs - rhs
    }

    // MARK: - Translate

    static public func - (lhs: CGRect, rhs: CGPoint) -> CGRect {
        return CGRect(x: lhs.origin.x - rhs.x, y: lhs.origin.y - rhs.y, width: lhs.width, height: lhs.height)
    }

    static public func + (lhs: CGRect, rhs: CGPoint) -> CGRect {
        return CGRect(x: lhs.origin.x + rhs.x, y: lhs.origin.y + rhs.y, width: lhs.width, height: lhs.height)
    }

    static public func - (lhs: CGRect, rhs: CGVector) -> CGRect {
        return CGRect(x: lhs.origin.x - rhs.dx, y: lhs.origin.y - rhs.dy, width: lhs.width, height: lhs.height)
    }

    static public func + (lhs: CGRect, rhs: CGVector) -> CGRect {
        return CGRect(x: lhs.origin.x + rhs.dx, y: lhs.origin.y + rhs.dy, width: lhs.width, height: lhs.height)
    }

    // MARK: - Expand

    static public func - (lhs: CGRect, rhs: CGSize) -> CGRect {
        return CGRect(x: lhs.origin.x, y: lhs.origin.y, width: lhs.width - rhs.width, height: lhs.height - rhs.height)
    }

    static public func + (lhs: CGRect, rhs: CGSize) -> CGRect {
        return CGRect(x: lhs.origin.x, y: lhs.origin.y, width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }
}

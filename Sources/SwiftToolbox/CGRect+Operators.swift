//
//  File.swift
//  
//
//  Created by Adam Wulf on 6/18/24.
//

import CoreGraphics

extension CGRect {
    // MARK: - Assignment Operators

    /// Translates the given `lhs` `CGRect` by the given `rhs` `CGVector`.
    static public func += (lhs: inout CGRect, rhs: CGVector) {
        lhs = lhs + rhs
    }

    /// Translates the given `lhs` `CGRect` by the given `rhs` `CGVector`.
    static public func -= (lhs: inout CGRect, rhs: CGVector) {
        lhs = lhs - rhs
    }

    // MARK: - Translate

    /// Translates the given `lhs` `CGRect` by the given `rhs` `CGPoint`.
    static public func - (lhs: CGRect, rhs: CGPoint) -> CGRect {
        return CGRect(x: lhs.origin.x - rhs.x, y: lhs.origin.y - rhs.y, width: lhs.width, height: lhs.height)
    }

    /// Translates the given `lhs` `CGRect` by the given `rhs` `CGPoint`.
    static public func + (lhs: CGRect, rhs: CGPoint) -> CGRect {
        return CGRect(x: lhs.origin.x + rhs.x, y: lhs.origin.y + rhs.y, width: lhs.width, height: lhs.height)
    }

    /// Translates the given `lhs` `CGRect` by the given `rhs` `CGVector`.
    static public func - (lhs: CGRect, rhs: CGVector) -> CGRect {
        return CGRect(x: lhs.origin.x - rhs.dx, y: lhs.origin.y - rhs.dy, width: lhs.width, height: lhs.height)
    }

    /// Translates the given `lhs` `CGRect` by the given `rhs` `CGVector`.
    static public func + (lhs: CGRect, rhs: CGVector) -> CGRect {
        return CGRect(x: lhs.origin.x + rhs.dx, y: lhs.origin.y + rhs.dy, width: lhs.width, height: lhs.height)
    }

    // MARK: - Expand

    /// Expands the given `lhs` `CGRect` by the given `rhs` `CGSize`.
    static public func - (lhs: CGRect, rhs: CGSize) -> CGRect {
        return CGRect(x: lhs.origin.x, y: lhs.origin.y, width: lhs.width - rhs.width, height: lhs.height - rhs.height)
    }

    /// Expands the given `lhs` `CGRect` by the given `rhs` `CGSize`.
    static public func + (lhs: CGRect, rhs: CGSize) -> CGRect {
        return CGRect(x: lhs.origin.x, y: lhs.origin.y, width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }
}

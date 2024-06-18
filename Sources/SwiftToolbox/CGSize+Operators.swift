//
//  File.swift
//  
//
//  Created by Adam Wulf on 6/18/24.
//

import CoreGraphics

extension CGSize {
    // MARK: - Scale

    /// Scales the `CGSize` by the given `Int`
    /// - Parameters:
    ///   - lhs: The `CGSize` to scale
    ///   - rhs: The `Int` to scale by
    static public func * (lhs: CGSize, rhs: Int) -> CGSize {
        return CGSize(width: lhs.width * CGFloat(rhs), height: lhs.height * CGFloat(rhs))
    }

    /// Scales the `CGSize` by the given `Int`
    /// - Parameters:
    ///   - lhs: The `CGSize` to scale
    ///   - rhs: The `Int` to scale by
    static public func / (lhs: CGSize, rhs: Int) -> CGSize {
        return CGSize(width: lhs.width / CGFloat(rhs), height: lhs.height / CGFloat(rhs))
    }

    /// Scales the `CGSize` by the given `CGFloat`
    /// - Parameters:
    ///   - lhs: The `CGSize` to scale
    ///   - rhs: The `CGFloat` to scale by
    static public func * (lhs: CGSize, rhs: CGFloat) -> CGSize {
        return CGSize(width: lhs.width * rhs, height: lhs.height * rhs)
    }

    /// Scales the `CGSize` by the given `CGFloat`
    /// - Parameters:
    ///   - lhs: The `CGSize` to scale
    ///   - rhs: The `CGFloat` to scale by
    static public func / (lhs: CGSize, rhs: CGFloat) -> CGSize {
        return CGSize(width: lhs.width / rhs, height: lhs.height / rhs)
    }
}

//
//  CGSize+Extensions.swift
//
//
//  Created by Adam Wulf on 5/8/22.
//

import Foundation
import CoreGraphics

extension CGSize {
    /// Initializes a `CGSize` with the given `width` and `height`
    /// - Parameters:
    ///   - width: The width of the `CGSize`
    ///   - height: The height of the `CGSize`
    public init(_ width: CGFloat, _ height: CGFloat) {
        self.init(width: width, height: height)
    }

    /// Initializes a `CGSize` with the given `width` and `height`
    /// - Parameters:
    ///   - width: The width of the `CGSize`
    ///   - height: The height of the `CGSize`
    public init(_ width: Double, _ height: Double) {
        self.init(width: width, height: height)
    }

    /// Initializes a `CGSize` with the given `width` and `height`
    /// - Parameters:
    ///   - width: The width of the `CGSize`
    ///   - height: The height of the `CGSize`
    public init(_ width: Int, _ height: Int) {
        self.init(width: width, height: height)
    }

    // MARK: - Min / Max

    /// The minimum of the `width` and `height` of the `CGSize`
    public var min: CGFloat {
        return Swift.min(width, height)
    }

    /// The maximum of the `width` and `height` of the `CGSize`
    public var max: CGFloat {
        return Swift.max(width, height)
    }

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

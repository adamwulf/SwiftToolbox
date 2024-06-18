//
//  CGSize+Extensions.swift
//
//
//  Created by Adam Wulf on 5/8/22.
//

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
    public var minDim: CGFloat {
        return min(width, height)
    }

    /// The maximum of the `width` and `height` of the `CGSize`
    public var maxDim: CGFloat {
        return max(width, height)
    }
}

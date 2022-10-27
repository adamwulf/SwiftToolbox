//
//  CGSize+Extensions.swift
//  
//
//  Created by Adam Wulf on 5/8/22.
//

import Foundation
import CoreGraphics

extension CGSize {
    public init(_ width: CGFloat, _ height: CGFloat) {
        self.init(width: width, height: height)
    }

    public init(_ width: Double, _ height: Double) {
        self.init(width: width, height: height)
    }

    public init(_ width: Int, _ height: Int) {
        self.init(width: width, height: height)
    }

    // MARK: - Min / Max

    public var min: CGFloat {
        return Swift.min(width, height)
    }

    public var max: CGFloat {
        return Swift.max(width, height)
    }

    // MARK: - Scale

    static public func * (lhs: CGSize, rhs: Int) -> CGSize {
        return CGSize(width: lhs.width * CGFloat(rhs), height: lhs.height * CGFloat(rhs))
    }

    static public func / (lhs: CGSize, rhs: Int) -> CGSize {
        return CGSize(width: lhs.width / CGFloat(rhs), height: lhs.height / CGFloat(rhs))
    }

    static public func * (lhs: CGSize, rhs: CGFloat) -> CGSize {
        return CGSize(width: lhs.width * rhs, height: lhs.height * rhs)
    }

    static public func / (lhs: CGSize, rhs: CGFloat) -> CGSize {
        return CGSize(width: lhs.width / rhs, height: lhs.height / rhs)
    }

}

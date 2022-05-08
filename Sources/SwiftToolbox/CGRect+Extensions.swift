//
//  File.swift
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
}

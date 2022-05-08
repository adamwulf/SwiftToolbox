//
//  File.swift
//  
//
//  Created by Adam Wulf on 3/14/21.
//

import CoreGraphics

extension CGRect {
    public func inset(by delta: CGFloat) -> CGRect {
        return insetBy(dx: delta, dy: delta)
    }

    public func expand(by delta: CGFloat) -> CGRect {
        return inset(by: -delta)
    }
}

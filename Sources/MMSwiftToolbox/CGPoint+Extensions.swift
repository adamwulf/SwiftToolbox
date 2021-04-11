//
//  File.swift
//  
//
//  Created by Adam Wulf on 4/11/21.
//

import CoreGraphics

extension CGPoint {
    public func distance(to point: CGPoint) -> CGFloat {
        let x2 = (point.x - x) * (point.x - x)
        let y2 = (point.y - y) * (point.y - y)
        return sqrt(x2 + y2)
    }
}

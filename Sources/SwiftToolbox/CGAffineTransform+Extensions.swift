//
//  File.swift
//  
//
//  Created by Adam Wulf on 7/30/22.
//

import CoreGraphics

public extension CGAffineTransform {

    var scale: CGFloat {
        return sqrt(a * a + c * c)
    }

    func translated(by point: CGPoint) -> CGAffineTransform {
        return translatedBy(x: point.x, y: point.y)
    }

    func translated(by vector: CGVector) -> CGAffineTransform {
        return translatedBy(x: vector.dx, y: vector.dy)
    }

    func scaled(by scale: CGFloat) -> CGAffineTransform {
        return scaledBy(x: scale, y: scale)
    }
}

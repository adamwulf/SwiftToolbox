//
//  File.swift
//  
//
//  Created by Adam Wulf on 6/18/24.
//

import CoreGraphics
import SwiftUI

extension CGRect {
    /// A subscript that returns a `CGPoint` within the rectangle based on a `UnitPoint`.
    /// - Parameter unitPoint: A `UnitPoint` representing a relative position within the rectangle.
    /// - Returns: A `CGPoint` corresponding to the position within the rectangle.
    @available(iOS 13.0, macOS 10.15, *)
    subscript(_ unitPoint: UnitPoint) -> CGPoint {
        return CGPoint(x: minX + unitPoint.x * width,
                       y: minY + unitPoint.y * height)
    }
}

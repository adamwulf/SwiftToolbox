//
//  UIBezierPath+Extensions.swift
//  Inkable
//
//  Created by Adam Wulf on 5/1/21.
//

#if canImport(UIKit)
import UIKit

extension UIBezierPath {
    /// Returns a new path that is the same as the current path, but stroked with the current line width, line cap style, line join style, and miter limit
    /// - Returns: A new path that is the same as the current path, but stroked
    public func strokedPath() -> UIBezierPath {
        return UIBezierPath(cgPath: cgPath.copy(strokingWithWidth: lineWidth,
                                                lineCap: lineCapStyle,
                                                lineJoin: lineJoinStyle,
                                                miterLimit: miterLimit))
    }
}
#endif

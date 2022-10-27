//
//  UIBezierPath+Extensions.swift
//  Inkable
//
//  Created by Adam Wulf on 5/1/21.
//

#if canImport(UIKit)
import UIKit

extension UIBezierPath {
    public func strokedPath() -> UIBezierPath {
        // miterLimit defaults to 10, so use default
        return UIBezierPath(cgPath: cgPath.copy(strokingWithWidth: lineWidth,
                                                lineCap: lineCapStyle,
                                                lineJoin: lineJoinStyle,
                                                miterLimit: miterLimit))
    }
}
#endif

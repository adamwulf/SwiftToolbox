//
//  UIImage+Extensions.swift
//  RubberDuck
//
//  Created by Adam Wulf on 1/14/23.
//

#if canImport(UIKit)
import UIKit

public extension UIImage {
    /// Crops the image to the input rect
    /// - parameter rect: The portion of the image to crop to
    /// - returns: The cropped image
    func cropped(to rect: CGRect) -> UIImage? {
        let rect = CGRect(x: rect.origin.x * scale, y: rect.origin.y * scale, width: rect.size.width * scale, height: rect.size.height * scale)
        guard let cgImage = cgImage?.cropping(to: rect) else {
            return nil
        }
        return UIImage(cgImage: cgImage)
    }
}
#endif

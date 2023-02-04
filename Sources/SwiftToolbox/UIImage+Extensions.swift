//
//  UIImage+Extensions.swift
//  RubberDuck
//
//  Created by Adam Wulf on 1/14/23.
//

import UIKit

public extension UIImage {
    func cropped(to rect: CGRect) -> UIImage? {
        let rect = CGRect(x: rect.origin.x * scale, y: rect.origin.y * scale, width: rect.size.width * scale, height: rect.size.height * scale)
        guard let cgImage = cgImage?.cropping(to: rect) else {
            return nil
        }
        return UIImage(cgImage: cgImage)
    }
}

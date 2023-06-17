//
//  File.swift
//  
//
//  Created by Adam Wulf on 6/17/23.
//

#if canImport(UIKit)
import UIKit

public extension UILabel {
    convenience init(text: String) {
        self.init(frame: .zero)
        self.text = text
    }
}
#endif

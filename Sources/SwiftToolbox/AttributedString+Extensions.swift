//
//  File.swift
//  
//
//  Created by Adam Wulf on 8/5/23.
//

import Foundation
import UIKit

@available(macCatalyst 15, *)
public extension AttributedString {
    mutating func setLineHeightMultiple(_ lineHeightMultiple: CGFloat) {
        var container = AttributeContainer()
        let para: NSMutableParagraphStyle = (self.paragraphStyle?.mutableCopy() as? NSMutableParagraphStyle) ?? NSMutableParagraphStyle()
        para.lineHeightMultiple = lineHeightMultiple
        container[AttributeScopes.UIKitAttributes.ParagraphStyleAttribute.self] = para
        self.mergeAttributes(container, mergePolicy: .keepNew)    }
}

//
//  File.swift
//  
//
//  Created by Adam Wulf on 8/5/23.
//

import Foundation
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

@available(iOS 15, *)
@available(macOS 12, *)
@available(macCatalyst 15, *)
public extension AttributedString {
    mutating func setLineHeightMultiple(_ lineHeightMultiple: CGFloat) {
        var container = AttributeContainer()
        let para: NSMutableParagraphStyle = (self.paragraphStyle?.mutableCopy() as? NSMutableParagraphStyle) ?? NSMutableParagraphStyle()
        para.lineHeightMultiple = lineHeightMultiple
#if canImport(UIKit)
        container[AttributeScopes.UIKitAttributes.ParagraphStyleAttribute.self] = para
#elseif canImport(AppKit)
        container[AttributeScopes.AppKitAttributes.ParagraphStyleAttribute.self] = para
#endif
        self.mergeAttributes(container, mergePolicy: .keepNew)    }
}

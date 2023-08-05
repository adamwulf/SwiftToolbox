//
//  UIFont+Extensions.swift
//
//
//  Created by Adam Wulf on 8/5/23.
//

import UIKit

/// This extension provides additional functionality to the UIFont class.
/// It allows for easy modification of font traits such as bold and italic,
/// as well as adjusting the font size.
public extension UIFont {
    /// This private method adds a given trait to the font.
    /// If the trait cannot be added, it returns the original font.
    ///
    /// - Parameter trait: The trait to be added to the font.
    /// - Returns: A UIFont with the added trait, or the original font if the trait cannot be added.
    private func adding(trait: UIFontDescriptor.SymbolicTraits) -> UIFont {
        var traits = fontDescriptor.symbolicTraits
        traits.insert(trait)
        if let descriptor = fontDescriptor.withSymbolicTraits(traits) {
            return UIFont(descriptor: descriptor, size: 0)
        }
        return self
    }

    /// This method returns a bold version of the font.
    ///
    /// - Returns: A UIFont with the bold trait added.
    func bold() -> UIFont {
        return adding(trait: .traitBold)
    }

    /// This method returns an italic version of the font.
    ///
    /// - Returns: A UIFont with the italic trait added.
    func italic() -> UIFont {
        return adding(trait: .traitItalic)
    }

    /// This method returns a version of the font with the size increased by 1 point.
    ///
    /// - Returns: A UIFont with a size one point larger than the original font.
    func larger() -> UIFont {
        return UIFont(descriptor: fontDescriptor, size: fontDescriptor.pointSize + 1)
    }

    /// This method returns a version of the font with the size decreased by 1 point.
    /// The minimum font size that can be returned is 1 point.
    ///
    /// - Returns: A UIFont with a size one point smaller than the original font, or a font of size 1 if the original font is already of size 1.
    func smaller() -> UIFont {
        return UIFont(descriptor: fontDescriptor, size: max(1, fontDescriptor.pointSize - 1))
    }
}

//
//  UILayoutConstraint+Extension.swift
//
//
//  Created by Adam Wulf on 1/7/23.
//

#if canImport(UIKit)
import UIKit

/// Extension to the NSLayoutConstraint class to provide additional methods
extension NSLayoutConstraint {
    /// Sets the priority of the constraint
    /// - Parameter priority: The priority to set
    /// - Returns: The constraint with the updated priority
    func prioritize(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }

    /// Activates the constraint
    /// - Returns: The activated constraint
    @discardableResult
    func activate() -> NSLayoutConstraint {
        self.isActive = true
        return self
    }
}
#endif

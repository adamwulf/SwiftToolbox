//
//  UILayoutConstraint+Extension.swift
//
//
//  Created by Adam Wulf on 1/7/23.
//

#if canImport(UIKit)
import UIKit

/// Extension to the NSLayoutConstraint class to provide additional methods
public extension NSLayoutConstraint {
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

/// An extension to `UILayoutPriority` that provides methods to increment and decrement the priority value.
public extension UILayoutPriority {

    /// Returns a new `UILayoutPriority` value that is incremented by 1, up to a maximum of `.required`.
    ///
    /// - Returns: A new `UILayoutPriority` value that is incremented by 1.
    func increment() -> UILayoutPriority {
        return UILayoutPriority(min(UILayoutPriority.required.rawValue, self.rawValue + 1))
    }

    /// Returns a new `UILayoutPriority` value that is decremented by 1, down to a minimum of 0.
    ///
    /// - Returns: A new `UILayoutPriority` value that is decremented by 1.
    func decrement() -> UILayoutPriority {
        return UILayoutPriority(max(0, self.rawValue - 1))
    }
}
#endif

//
//  UIView+Extensions.swift
//  
//
//  Created by Adam Wulf on 6/25/22.
//

#if canImport(UIKit)
import UIKit

/// Extension to the UIView class to provide additional methods
public extension UIView {
    /// Wraps the view in a new view
    /// - Parameter priority: The priority to set for the constraints
    /// - Returns: The wrapping view
    func wrapInView(_ priority: UILayoutPriority = .required) -> UIView {
        let wrapping = UIView()
        wrapping.translatesAutoresizingMaskIntoConstraints = false
        self.translatesAutoresizingMaskIntoConstraints = false
        wrapping.addSubview(self)
        self.constrainToSuperview(priority)
        return wrapping
    }

    /// Sets the view's constraints to hug its parent view
    /// - Parameter safeArea: Whether or not to use the safe area layout guide
    /// - Parameter priority: The priority to set for the constraints
    func constrainToSuperview(safeArea: Bool = false, _ priority: UILayoutPriority = .required) {
        guard let superview = superview else {
            assertionFailure("cannot constraint to nil superview")
            return
        }
        if #available(iOS 11.0, *), safeArea {
            superview.addConstraint(leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor).prioritize(priority))
            superview.addConstraint(trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor).prioritize(priority))
            superview.addConstraint(topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor).prioritize(priority))
            superview.addConstraint(bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor).prioritize(priority))
        } else {
            superview.addConstraint(leadingAnchor.constraint(equalTo: superview.leadingAnchor).prioritize(priority))
            superview.addConstraint(trailingAnchor.constraint(equalTo: superview.trailingAnchor).prioritize(priority))
            superview.addConstraint(topAnchor.constraint(equalTo: superview.topAnchor).prioritize(priority))
            superview.addConstraint(bottomAnchor.constraint(equalTo: superview.bottomAnchor).prioritize(priority))
        }
    }
}
#endif

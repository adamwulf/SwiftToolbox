//
//  UIView+Extensions.swift
//  
//
//  Created by Adam Wulf on 6/25/22.
//

#if canImport(UIKit)
import UIKit

public extension UIView {
    func layoutHuggingParent(safeArea: Bool = false) {
        guard let superview = self.superview else { assertionFailure(); return }
        self.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *), safeArea {
            self.leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor).isActive = true
            self.trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor).isActive = true
            self.topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor).isActive = true
            self.bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor).isActive = true
        } else {
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
            self.topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        }
    }
}
#endif

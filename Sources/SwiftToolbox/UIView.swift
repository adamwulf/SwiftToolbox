//
//  File.swift
//  
//
//  Created by Adam Wulf on 6/25/22.
//

#if canImport(UIKit)
import UIKit

public extension UIView {
    func layoutHuggingParent() {
        guard let superview = self.superview else { assertionFailure(); return }
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
        self.topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
    }
}
#endif

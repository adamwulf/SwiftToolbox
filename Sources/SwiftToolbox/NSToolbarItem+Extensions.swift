//
//  File.swift
//  
//
//  Created by Adam Wulf on 2/4/23.
//

#if canImport(AppKit)
import AppKit

public extension NSToolbarItem {
    /// Set both the target and action for the toolbar item
    /// - parameter target: The `target` for the item
    /// - parameter action: The `action` for the item
    func set(target: AnyObject, action: Selector) {
        self.target = target
        self.action = action
    }
}
#endif

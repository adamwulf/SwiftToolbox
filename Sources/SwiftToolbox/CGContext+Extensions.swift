//
//  CGContext+Extensions.swift
//  
//
//  Created by Adam Wulf on 6/28/22.
//

import CoreGraphics

/// Helper methods for `CGContext`
public extension CGContext {
    /// Saves the `CGContext` graphics state before running the input `actions` block. Restores the state after the block.
    /// - parameter actions: The block to run after the saved state and before restoring.
    func saveRestore(actions: () -> Void) {
        saveGState()
        actions()
        restoreGState()
    }
}

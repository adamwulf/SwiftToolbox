//
//  File.swift
//  
//
//  Created by Adam Wulf on 6/28/22.
//

import CoreGraphics

extension CGContext {
    func saveRestore(actions: () -> Void) {
        saveGState()
        actions()
        restoreGState()
    }
}

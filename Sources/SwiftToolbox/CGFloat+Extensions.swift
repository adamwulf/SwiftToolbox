//
//  File.swift
//  
//
//  Created by Adam Wulf on 9/11/22.
//

import Foundation
import CoreGraphics

public extension CGFloat {
    func squared() -> CGFloat {
        return self * self
    }

    func cubed() -> CGFloat {
        return self * self * self
    }

    func pow(_ power: Int) -> CGFloat {
        var ret = self
        for _ in 1..<power {
            ret *= self
        }
        return ret
    }
}

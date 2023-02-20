//
//  File.swift
//  
//
//  Created by Adam Wulf on 2/19/23.
//

import Foundation

public extension Dictionary {
    /// Merges the input dictionary with this dictionary, preferring existing values in the case of a key conflict
    func merging(_ other: [Key: Value]) -> [Key: Value] {
        return merging(other, uniquingKeysWith: { val1, _ in
            return val1
        })
    }
}

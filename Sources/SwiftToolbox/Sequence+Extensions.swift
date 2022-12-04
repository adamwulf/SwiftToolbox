//
//  File.swift
//  
//
//  Created by Adam Wulf on 7/31/22.
//

import Foundation

extension Sequence {
    public func compactMap<ElementOfResult>(_ transform: (Self.Element, Int) throws -> ElementOfResult?) rethrows -> [ElementOfResult] {
        var ret: [ElementOfResult] = []
        var index = 0
        for item in self {
            if let result = try transform(item, index) {
                ret.append(result)
            }
            index += 1
        }
        return ret
    }
    public func map<ElementOfResult>(_ transform: (Self.Element, Int) throws -> ElementOfResult) rethrows -> [ElementOfResult] {
        var ret: [ElementOfResult] = []
        var index = 0
        for item in self {
            ret.append(try transform(item, index))
            index += 1
        }
        return ret
    }
}

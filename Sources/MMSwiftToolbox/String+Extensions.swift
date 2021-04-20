//
//  File.swift
//  
//
//  Created by Adam Wulf on 4/16/21.
//

import Foundation

extension String {
    func trimmingCharacters(in chars: String) -> String {
        return self.trimmingCharacters(in: CharacterSet(charactersIn: chars))
    }

    func indices(of occurrence: String) -> [Int] {
        var indices = [Int]()
        var position = startIndex
        while let range = range(of: occurrence, range: position..<endIndex) {
            let i = distance(from: startIndex,
                             to: range.lowerBound)
            indices.append(i)
            let offset = occurrence.distance(from: occurrence.startIndex,
                                             to: occurrence.endIndex) - 1
            guard let after = index(range.lowerBound, offsetBy: offset, limitedBy: endIndex)
            else {
                break
            }
            position = index(after: after)
        }
        return indices
    }

    func ranges(of searchString: String) -> [Range<String.Index>] {
        let _indices = indices(of: searchString)
        return _indices.map({ index(startIndex, offsetBy: $0)..<index(startIndex, offsetBy: $0+searchString.count) })
    }
}

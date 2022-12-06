//
//  String+Extensions.swift
//  
//
//  Created by Adam Wulf on 4/16/21.
//

import Foundation

extension String {
    public func trimmingCharacters(in chars: String) -> String {
        return self.trimmingCharacters(in: CharacterSet(charactersIn: chars))
    }

    public func countOccurrences<Target>(of string: Target) -> Int where Target: StringProtocol {
        return components(separatedBy: string).count - 1
    }

    public func countOccurrences(of chars: CharacterSet) -> Int {
        return components(separatedBy: chars).count - 1
    }

    @_disfavoredOverload
    public func contains(_ any: Character...) -> Bool {
        return any.contains(where: { self.contains($0) })
    }

    func contains(charactersIn characters: String) -> Bool {
        return characters.contains(where: { self.contains($0) })
    }
}

extension String {
    public func slashEscape(_ characters: String) -> String {
        var result = ""
        for char in self {
            if char == "\\" {
                result += "\\\\"
            } else if characters.contains(char) {
                result += "\\\(char)"
            } else {
                result += String(char)
            }
        }
        return result
    }
}

// https://gist.github.com/BetterProgramming/ac4f639c915ef0560fcca5208d9456f9#file-firstoccur-swift
// https://gist.github.com/BetterProgramming/37e2019711c00ac678600a878e2d879f#file-transformhelper-swift
extension String {
    public func indices(of occurrence: String) -> [Int] {
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

    public func ranges(of searchString: String) -> [Range<String.Index>] {
        let _indices = indices(of: searchString)
        return _indices.map({ index(startIndex, offsetBy: $0)..<index(startIndex, offsetBy: $0 + searchString.count) })
    }
}

//
//  String+Extensions.swift
//  
//
//  Created by Adam Wulf on 4/16/21.
//

import Foundation

/// An extension to the `String` class.
public extension String {
    /// Trims the characters in the given string from the receiver.
    /// - Parameter chars: The characters to trim.
    /// - Returns: The trimmed string.
    func trimmingCharacters(in chars: String) -> String {
        return self.trimmingCharacters(in: CharacterSet(charactersIn: chars))
    }

    /// Counts the number of occurrences of the given string in the receiver.
    /// - Parameter string: The string to count.
    /// - Returns: The number of occurrences.
    func countOccurrences<Target>(of string: Target) -> Int where Target: StringProtocol {
        return components(separatedBy: string).count - 1
    }

    /// Counts the number of occurrences of the given character set in the receiver.
    /// - Parameter chars: The character set to count.
    /// - Returns: The number of occurrences.
    func countOccurrences(of chars: CharacterSet) -> Int {
        return components(separatedBy: chars).count - 1
    }

    /// Checks if the receiver contains any of the given characters.
    /// - Parameter any: The characters to check for.
    /// - Returns: `true` if the receiver contains any of the given characters, `false` otherwise.
    @_disfavoredOverload
    func contains(_ any: Character...) -> Bool {
        return any.contains(where: { self.contains($0) })
    }

    /// Checks if the receiver contains any of the characters in the given string.
    /// - Parameter characters: The characters to check for.
    /// - Returns: `true` if the receiver contains any of the given characters, `false` otherwise.
    func contains(charactersIn characters: String) -> Bool {
        return characters.contains(where: { self.contains($0) })
    }

    /// Escapes the given characters in the receiver with a backslash.
    /// - Parameter characters: The characters to escape.
    /// - Returns: The escaped string.
    func slashEscape(_ characters: String) -> String {
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

    /// Finds the indices of the given string in the receiver.
    /// - Parameter occurrence: The string to search for.
    /// - Returns: An array of indices.
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

    /// Finds the ranges of the given string in the receiver.
    /// - Parameter searchString: The string to search for.
    /// - Returns: An array of ranges.
    func ranges(of searchString: String) -> [Range<String.Index>] {
        let _indices = indices(of: searchString)
        return _indices.map({ index(startIndex, offsetBy: $0)..<index(startIndex, offsetBy: $0 + searchString.count) })
    }

    /// Removes all non-alphanumeric characters, and replaces whitespace with `-`
    var filenameSafe: String {
        return components(separatedBy: .whitespacesAndNewlines).joined(separator: "-")
            .components(separatedBy: .alphanumerics.union(CharacterSet(charactersIn: "-")).inverted).joined()
    }

    /// Returns a new string made by removing from the end of the string all characters contained in a given character set.
    ///
    /// - Parameter set: The character set containing the characters to remove.
    /// - Returns: A new string made by removing from the end of the string all characters contained in `set`.
    func trimmingSuffixCharacters(in set: CharacterSet) -> String {
        var endIndex = self.endIndex
        while endIndex > self.startIndex,
              let char = self[index(before: endIndex)].unicodeScalars.first,
              set.contains(char) {
            endIndex = index(before: endIndex)
        }
        return String(self[..<endIndex])
    }

    /// Returns a new string made by removing the specified prefix from the original string.
    ///
    /// - Parameter prefix: The prefix to remove.
    /// - Returns: A new string made by removing the specified prefix from the original string, or the original string if it does not start with the specified prefix.
    func removePrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }

    /// Returns a new string made by removing the specified suffix from the original string.
    ///
    /// - Parameter suffix: The suffix to remove.
    /// - Returns: A new string made by removing the specified suffix from the original string, or the original string if it does not end with the specified suffix.
    func removeSuffix(_ suffix: String) -> String {
        guard self.hasSuffix(suffix) else { return self }
        return String(self.dropLast(suffix.count))
    }
}

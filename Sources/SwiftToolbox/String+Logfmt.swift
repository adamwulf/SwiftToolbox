//
//  File.swift
//  
//
//  Created by Adam Wulf on 12/4/22.
//

import Foundation

public protocol CustomLogfmtStringConvertible {
    var logfmtDescription: String { get }
}

public extension String {
    /// Format the input object as lotfmt as best as possible. Supports dictionaries, arrays, strings, numbers, CustomStringConvertables
    /// - seealso: https://www.brandur.org/logfmt
    @available(iOS 13.0, macOS 10.15, *)
    static func logfmt(_ object: Any) -> String {
        return Self.logfmt(object, attribute: "")
    }
}

private extension String {
    static func logfmt(_ object: Any, attribute: String) -> String {
        switch object {
        case let object as String:
            return format(attribute: attribute, value: object)
        case let object as [String: Any]:
            return object.sorted(by: { $0.key < $1.key }).map({ keyVal in
                return logfmt(keyVal.value, attribute: attribute.dot(keyVal.key))
            }).joined(separator: " ")
        case let object as [Any]:
            let mapped = object.map({ item, index in
                return logfmt(item, attribute: attribute.dot("\(index)"))
            })
            return mapped.joined(separator: " ")
        case let object as CustomLogfmtStringConvertible:
            return logfmt(object.logfmtDescription, attribute: attribute)
        case let object as CustomStringConvertible:
            return logfmt(object.description, attribute: attribute)
        case let object as CustomDebugStringConvertible:
            return logfmt(object.debugDescription, attribute: attribute)
        default:
            return logfmt("\(object)", attribute: attribute)
        }
    }

    static func format(attribute: String, value: String) -> String {
        let attribute = attribute.replacingOccurrences(of: " ", with: "_")
        let value = value.contains(charactersIn: "\" ") ? value.slashEscape("\"").wrapInQuotes() : value
        if attribute.isEmpty {
            return value
        } else if value.isEmpty {
            return attribute
        } else {
            return attribute + "=" + value
        }
    }
}

private extension String {
    func dot(_ str: String) -> String {
        if self.isEmpty {
            return str
        } else {
            return "\(self).\(str)"
        }
    }

    func wrapInQuotes() -> String {
        return "\"\(self)\""
    }
}

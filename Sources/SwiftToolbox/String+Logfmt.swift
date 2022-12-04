//
//  File.swift
//  
//
//  Created by Adam Wulf on 12/4/22.
//

import Foundation

public extension String {
    /// Format the input object as lotfmt as best as possible. Supports dictionaries, arrays, strings, numbers, CustomStringConvertables
    /// - seealso: https://www.brandur.org/logfmt
    @available(iOS 13.0, macOS 10.15, *)
    static func logfmt(_ object: Any) -> String {
        return Self.logfmt(object, attribute: "")
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

    func eqValue(_ str: String) -> String {
        if self.isEmpty {
            return str
        } else {
            return "\(self)=\(str)"
        }
    }

    @available(iOS 13.0, macOS 10.15, *)
    static private func logfmt(_ object: Any, attribute: String) -> String {
        switch object {
        case let object as [String: Any]:
            return object.sorted(by: { $0.key < $1.key }).map({ keyVal in
                return logfmt(keyVal.value, attribute: attribute.dot(keyVal.key))
            }).joined(separator: " ")
        case let object as [Any]:
            let mapped = object.map({ item, index in
                return logfmt(item, attribute: attribute.dot("\(index)"))
            })
            return mapped.joined(separator: " ")
        case let object as String:
            return attribute.eqValue(object.contains("\"", " ") ? "\"\(object.slashEscaping("\""))\"" : object)
        case let object as any Numeric:
            return attribute.eqValue("\(object)")
        case let object as CustomStringConvertible:
            return logfmt(object.description, attribute: attribute)
        case let object as CustomDebugStringConvertible:
            return logfmt(object.debugDescription, attribute: attribute)
        default:
            return logfmt("\(object)", attribute: attribute)
        }
    }
}

//
//  File.swift
//  
//
//  Created by Adam Wulf on 7/18/24.
//

import Foundation

public struct FormData {
    public let name: String
    public let filename: String?
    public let contentType: String?
    public let value: Data

    enum ParserState {
        case readingHeaders
        case readingValue
    }

    public static func parseMultipartFormData(from fileContent: String) -> (boundary: String, formData: [FormData])? {
        let lines = fileContent.components(separatedBy: .newlines)
        guard let boundaryLine = lines.first, boundaryLine.hasPrefix("--") else {
            return nil
        }

        let boundary = String(boundaryLine.dropFirst(2))
        var formDataArray: [FormData] = []
        var currentName: String?
        var currentFilename: String?
        var currentContentType: String?
        var currentValue: Data?
        var state: ParserState = .readingHeaders

        for line in lines.dropFirst() {
            if line.hasPrefix("--\(boundary)") {
                if let name = currentName, let value = currentValue {
                    formDataArray.append(FormData(name: name, filename: currentFilename, contentType: currentContentType, value: value))
                }
                currentName = nil
                currentFilename = nil
                currentContentType = nil
                currentValue = nil
                state = .readingHeaders
            } else if state == .readingHeaders {
                if line.hasPrefix("Content-Disposition: form-data;") {
                    let components = line.components(separatedBy: "; ")
                    for component in components {
                        if component.hasPrefix("name=") {
                            currentName = component.replacingOccurrences(of: "name=", with: "")
                                .trimmingCharacters(in: CharacterSet(charactersIn: "\""))
                        } else if component.hasPrefix("filename=") {
                            currentFilename = component.replacingOccurrences(of: "filename=", with: "")
                                .trimmingCharacters(in: CharacterSet(charactersIn: "\""))
                        }
                    }
                } else if line.hasPrefix("Content-Type:") {
                    currentContentType = line.replacingOccurrences(of: "Content-Type: ", with: "").trimmingCharacters(in: .whitespaces)
                } else if line.isEmpty {
                    state = .readingValue
                    currentValue = Data()
                }
            } else if state == .readingValue {
                if let data = line.data(using: .utf8) {
                    currentValue?.append(data)
                    currentValue?.append(Data("\n".utf8)) // Add newline character back
                }
            }
        }

        // Attempt to decode base64 if content type suggests binary data
        for i in 0..<formDataArray.count {
            if let utf8String = String(data: formDataArray[i].value, encoding: .utf8) {
                let trimmedValue = utf8String.trimmingCharacters(in: .whitespacesAndNewlines)
                if let decodedData = Data(base64Encoded: Data(trimmedValue.utf8)) {
                    formDataArray[i] = FormData(
                        name: formDataArray[i].name,
                        filename: formDataArray[i].filename,
                        contentType: formDataArray[i].contentType,
                        value: decodedData)
                }
            }
        }

        return (boundary, formDataArray)
    }
}

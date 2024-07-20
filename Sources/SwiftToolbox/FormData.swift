//
//  File.swift
//  
//
//  Created by Adam Wulf on 7/18/24.
//

import Foundation

@available(macOS 13.0, *)
public struct FormData {
    public let name: String
    public let filename: String?
    public let contentType: String?
    public let value: Data

    enum ParserState {
        case readingHeaders
        case startReadingValue
        case readingValue
    }

    static func processLines(in data: Data) -> [Data.SubSequence] {
        let lines = data.split(separator: UInt8(ascii: "\n"), omittingEmptySubsequences: false)
        var ret: [Data.SubSequence] = []
        let carriageReturn = UInt8(ascii: "\r")
        var startIndex: Data.Index?
        for line in lines {
            let indexBefore = line.index(before: line.endIndex)
            if indexBefore >= line.startIndex, line[indexBefore] == carriageReturn {
                let start = startIndex ?? line.startIndex
                ret.append(data[start..<indexBefore])
                startIndex = nil
            } else if startIndex == nil {
                startIndex = line.startIndex
            }
        }
        if let startIndex = startIndex {
            ret.append(data[startIndex...])
        }
        return ret
    }

    public static func parseMultipartFormData(from fileContent: Data) -> (boundary: String, formData: [FormData])? {
        let lines = processLines(in: fileContent)

        guard
            let boundaryLine = lines.first,
            let boundaryString = String(data: Data(boundaryLine), encoding: .utf8),
            boundaryString.hasPrefix("--")
        else {
            return nil
        }

        let boundary = String(boundaryString.dropFirst(2))
        var formDataArray: [FormData] = []
        var currentName: String?
        var currentFilename: String?
        var currentContentType: String?
        var currentValue = Data()
        var state: ParserState = .readingHeaders

        for line in lines.dropFirst() {
            if let lineString = String(data: Data(line), encoding: .utf8), lineString.hasPrefix("--\(boundary)") {
                if let name = currentName {
                    formDataArray.append(FormData(
                        name: name,
                        filename: currentFilename,
                        contentType: currentContentType,
                        value: currentValue))
                }
                currentName = nil
                currentFilename = nil
                currentContentType = nil
                currentValue = Data()
                state = .readingHeaders
            } else if state == .readingHeaders {
                if let lineString = String(data: Data(line), encoding: .utf8) {
                    if lineString.hasPrefix("Content-Disposition: form-data;") {
                        let components = lineString.components(separatedBy: "; ")
                        for component in components {
                            if component.hasPrefix("name=") {
                                currentName = component.replacingOccurrences(of: "name=", with: "")
                                    .trimmingCharacters(in: CharacterSet(charactersIn: "\""))
                            } else if component.hasPrefix("filename=") {
                                currentFilename = component.replacingOccurrences(of: "filename=", with: "")
                                    .trimmingCharacters(in: CharacterSet(charactersIn: "\""))
                            }
                        }
                    } else if lineString.hasPrefix("Content-Type:") {
                        currentContentType = lineString.replacingOccurrences(of: "Content-Type: ", with: "")
                            .trimmingCharacters(in: .whitespaces)
                    } else if lineString.isEmpty {
                        state = .startReadingValue
                    }
                }
            } else if state == .startReadingValue {
                currentValue.append(line)
                state = .readingValue
            } else if state == .readingValue {
                // Add line ending characters back if we have been parsing the value data
                currentValue.append(UInt8(ascii: "\r"))
                currentValue.append(UInt8(ascii: "\n"))
                currentValue.append(line)
            }
        }

        // Add the last form data if any
        if let name = currentName {
            formDataArray.append(FormData(name: name, filename: currentFilename, contentType: currentContentType, value: currentValue))
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

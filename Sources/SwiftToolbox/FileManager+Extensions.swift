//
//  FileManager+Extensions.swift
//  
//
//  Created by Adam Wulf on 9/18/22.
//

import Foundation

public extension FileManager {
    /// Checks if the given URL is a directory.
    /// - Parameter url: The URL to check.
    /// - Returns: `true` if the URL is a directory, `false` otherwise.
    func isDirectory(_ url: URL) -> Bool {
        guard url.isFileURL else { return false }
        var isDirectory: ObjCBool = false
        let exists = FileManager.default.fileExists(atPath: url.path, isDirectory: &isDirectory)
        return exists && isDirectory.boolValue
    }

    /// Checks if the given path is a directory.
    /// - Parameter path: The path to check.
    /// - Returns: `true` if the path is a directory, `false` otherwise.
    func isDirectory(atPath path: String) -> Bool {
        var isDirectory: ObjCBool = false
        let exists = FileManager.default.fileExists(atPath: path, isDirectory: &isDirectory)
        return exists && isDirectory.boolValue
    }
}

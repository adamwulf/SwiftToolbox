//
//  File.swift
//  
//
//  Created by Adam Wulf on 9/18/22.
//

import Foundation

extension FileManager {
    func isDirectory(_ url: URL) -> Bool {
        guard url.isFileURL else { return false }
        var isDirectory: ObjCBool = false
        let exists = FileManager.default.fileExists(atPath: url.path, isDirectory: &isDirectory)
        return exists && isDirectory.boolValue
    }

    func isDirectory(atPath path: String) -> Bool {
        var isDirectory: ObjCBool = false
        let exists = FileManager.default.fileExists(atPath: path, isDirectory: &isDirectory)
        return exists && isDirectory.boolValue
    }
}

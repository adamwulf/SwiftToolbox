//
//  File.swift
//  
//
//  Created by Adam Wulf on 6/13/22.
//

import Foundation

public extension Data {
    var hexString: String {
        return map { String(format: "%02hhx", $0) }.joined()
    }
}

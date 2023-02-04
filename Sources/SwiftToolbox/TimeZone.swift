//
//  TimeZone.swift
//  
//
//  Created by Adam Wulf on 2/4/23.
//

import Foundation

public extension TimeZone {

    /// The UTC timezone
    static var utc: TimeZone {
        return TimeZone(identifier: "UTC")!
    }
}

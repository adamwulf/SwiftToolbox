//
//  File.swift
//  
//
//  Created by Adam Wulf on 3/15/23.
//

import StoreKit

/// Helper methods for `StoreKit.Product.SubscriptionPeriod.Unit`
@available(iOS 15.0, macOS 12.0, *)
public extension StoreKit.Product.SubscriptionPeriod.Unit {

    /// Returns the name of the unit as a `String`.
    ///
    /// - Parameter plural: A `Bool` value indicating whether the name should be plural or not. Default is `false`.
    /// - Returns: The name of the unit as a `String`.
    func unitName(plural: Bool = false) -> String {
        if plural == false {
            switch self {
            case .day: return "day"
            case .week: return "week"
            case .month: return "month"
            case .year: return "year"
            @unknown default: return "\(self)"
            }
        } else {
            switch self {
            case .day: return "days"
            case .week: return "weeks"
            case .month: return "months"
            case .year: return "years"
            @unknown default: return "\(self)s"
            }
        }
    }
}

//
//  ByteSize.swift
//  Muse
//
//  Created by Adam Wulf on 5/26/22.
//  Copyright © 2022 Muse Software, Inc. All rights reserved.
//

import Foundation

/// Represents a size in bytes
public enum ByteSize: RawRepresentable, AdditiveArithmetic, Comparable, CustomStringConvertible {
    case zero
    case byte(_ num: Int = 1)
    case kilobyte(_ num: Int = 1)
    case megabyte(_ num: Int = 1)
    case gigabyte(_ num: Int = 1)

    /// Initializes a `ByteSize` with the input number of bytes
    /// - parameter rawValue: The number of bytes as a `UInt64`
    public init?(_ rawValue: UInt64) {
        guard rawValue < UInt64(Int.max) else { return nil }
        self = .byte(Int(rawValue))
    }

    /// Initializes a `ByteSize` with the input number of bytes
    /// - parameter rawValue: The number of bytes as an `Int64`
    public init?(_ rawValue: Int64) {
        guard rawValue < Int64(Int.max) else { return nil }
        self = .byte(Int(rawValue))
    }

    /// Initializes a `ByteSize` with the input number of bytes
    /// - parameter rawValue: The number of bytes as an `Int`
    public init(rawValue: Int) {
        self = .byte(rawValue)
    }

    /// Initializes a `ByteSize` with the input number of bytes
    /// - parameter rawValue: The number of bytes as an `Int`
    public init(_ rawValue: Int) {
        self = .byte(rawValue)
    }

    /// The number of bytes in the `ByteSize` as an `Int`
    public var bytes: Int {
        return rawValue
    }

    /// The number of kilobytes in the `ByteSize` as an `Int`
    public var KBs: Int {
        return rawValue / ByteSize.kilobyte().rawValue
    }

    /// The number of megabytes in the `ByteSize` as an `Int`
    public var MBs: Int {
        return rawValue / ByteSize.megabyte().rawValue
    }

    /// The number of gigabytes in the `ByteSize` as an `Int`
    public var GBs: Int {
        return rawValue / ByteSize.gigabyte().rawValue
    }

    /// The `ByteSize` represented as a human-readable string
    public var humanReadable: String {
        if GBs != 0 {
            let GBWithRemainder: Float = Float(MBs - GBs * 1024) / 1024 + Float(GBs)

            return "\(String(format: "%.1f", GBWithRemainder)) GB"
        } else if MBs != 0 {
            let MBWithRemainder: Float = Float(KBs - MBs * 1024) / 1024 + Float(MBs)

            return "\(String(format: "%.1f", MBWithRemainder)) MB"
        } else if KBs != 0 {
            let KBWithRemainder: Float = Float(rawValue - KBs * 1024) / 1024 + Float(KBs)

            return "\(String(format: "%.1f", KBWithRemainder)) KB"
        } else {
            return "\(rawValue) B"
        }
    }

    /// Converts the byte size to a human-readable string in GB
    public var humanGBs: String {
        let GBWithRemainder: Float = Float(MBs - GBs * 1024) / 1024 + Float(GBs)
        return "\(String(format: "%.1f", GBWithRemainder)) GB"
    }

    /// Converts the byte size to a human-readable string in MB
    public var humanMBs: String {
        let MBWithRemainder: Float = Float(KBs - MBs * 1024) / 1024 + Float(MBs)
        return "\(String(format: "%.1f", MBWithRemainder)) MB"
    }

    /// Converts the byte size to a human-readable string in KB
    public var humanKBs: String {
        let KBWithRemainder: Float = Float(rawValue - KBs * 1024) / 1024 + Float(KBs)
        return "\(String(format: "%.1f", KBWithRemainder)) KB"
    }

    /// Converts the byte size to a human-readable string in B
    public var humanBs: String {
        return "\(rawValue) B"
    }

    // MARK: RawRepresentable

    /// The number of bytes of this `ByteSize`
    public var rawValue: Int {
        switch self {
        case .zero:
            return 0
        case .byte(let num):
            return num
        case .kilobyte(let num):
            return num * 1024
        case .megabyte(let num):
            return num * 1024 * 1024
        case .gigabyte(let num):
            return num * 1024 * 1024 * 1024
        }
    }

    // MARK: AdditiveArithmetic

    /// Subtracts two byte sizes
    public static func - (lhs: ByteSize, rhs: ByteSize) -> ByteSize {
        return ByteSize.byte(lhs.rawValue - rhs.rawValue)
    }

    /// Adds two byte sizes
    public static func + (lhs: ByteSize, rhs: ByteSize) -> ByteSize {
        return ByteSize.byte(lhs.rawValue + rhs.rawValue)
    }

    /// Returns the modulo of two byte sizes
    public static func % (lhs: ByteSize, rhs: ByteSize) -> ByteSize {
        return ByteSize.byte(lhs.rawValue % rhs.rawValue)
    }

    // MARK: CGFloat Arithmetic

    /// Multiplies a byte size by a CGFloat
    public static func * (lhs: ByteSize, rhs: CGFloat) -> ByteSize {
        return ByteSize.byte(Int(CGFloat(lhs.rawValue) * rhs))
    }

    /// Divides a byte size by a CGFloat
    public static func / (lhs: ByteSize, rhs: CGFloat) -> ByteSize {
        return lhs * (1 / rhs)
    }

    /// Multiplies a byte size by an Int
    public static func * (lhs: ByteSize, rhs: Int) -> ByteSize {
        return ByteSize.byte(lhs.rawValue * rhs)
    }

    /// Divides a byte size by an Int
    public static func / (lhs: ByteSize, rhs: Int) -> ByteSize {
        return ByteSize.byte(lhs.rawValue / rhs)
    }

    // MARK: Comparable

    /// - returns: true if the two `ByteSize` are equal, `false` otherwise
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }

    /// - returns: true if the left `ByteSize` is smaller than the right `ByteSize`, `false` otherwise
    public static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }

    /// - returns: true if the left `ByteSize` is larger than the right `ByteSize`, `false` otherwise
    public static func > (lhs: Self, rhs: Self) -> Bool {
        return lhs.rawValue > rhs.rawValue
    }

    /// - returns: true if the left `ByteSize` is smaller than or equal to the right `ByteSize`, `false` otherwise
    public static func <= (lhs: Self, rhs: Self) -> Bool {
        return lhs.rawValue <= rhs.rawValue
    }

    /// - returns: true if the left `ByteSize` is larger than or equal to the right `ByteSize`, `false` otherwise
    public static func >= (lhs: Self, rhs: Self) -> Bool {
        return lhs.rawValue >= rhs.rawValue
    }

    // MARK: CustomStringConvertible

    /// A human readable description of a `ByteSize`.
    public var description: String {
        switch self {
        case .zero:
            return "0B"
        case .byte(let num):
            return "\(num)B"
        case .kilobyte(let num):
            return "\(num)KB"
        case .megabyte(let num):
            return "\(num)MB"
        case .gigabyte(let num):
            return "\(num)GB"
        }
    }
}

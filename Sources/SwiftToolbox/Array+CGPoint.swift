//
//  File.swift
//  
//
//  Created by Adam Wulf on 6/18/24.
//

import Foundation
import CoreGraphics

/// Provides extensions for arrays of CGPoint for geometric calculations.
public extension Array where Element == CGPoint {
    /// Returns a new array where the points are sorted in a counter-clockwise direction.
    /// - Note: This assumes inverted Y for CoreGraphics
    /// - Returns: An array of CGPoint sorted in clockwise order.
    func sortedClockwise() -> [CGPoint] {
        guard count > 0 else { return [] }

        let center = reduce(CGPoint.zero) { CGPoint(x: $0.x + $1.x / CGFloat(count), y: $0.y + $1.y / CGFloat(count)) }

        func less(_ a: CGPoint, _ b: CGPoint) -> Bool {
            if a.x - center.x >= 0 && b.x - center.x < 0 {
                return false
            }
            if a.x - center.x < 0 && b.x - center.x >= 0 {
                return true
            }
            if a.x - center.x == 0 && b.x - center.x == 0 {
                if a.y - center.y >= 0 || b.y - center.y >= 0 {
                    return a.y < b.y
                }
                return b.y < a.y
            }

            // compute the cross product of vectors (center -> a) x (center -> b)
            let det = (a.x - center.x) * (b.y - center.y) - (b.x - center.x) * (a.y - center.y)
            if det < 0 {
                return false
            }
            if det > 0 {
                return true
            }

            // points a and b are on the same line from the center
            // check which point is closer to the center
            let d1 = (a.x - center.x) * (a.x - center.x) + (a.y - center.y) * (a.y - center.y)
            let d2 = (b.x - center.x) * (b.x - center.x) + (b.y - center.y) * (b.y - center.y)
            return d1 > d2
        }

        let ret = sorted(by: less)
        guard let index = ret.firstIndex(of: self[0]) else { return ret }
        return Array(ret[index...] + ret[0..<index])
    }

    /// Sorts the array of CGPoint in place in a clockwise direction.
    /// - Note: This assumes inverted Y for CoreGraphics
    mutating func sortClockwise() {
        self = sortedClockwise()
    }

    /// Calculates the signed area of the polygon formed by the points in the array.
    /// - Returns: The signed area of the polygon as CGFloat.
    func signedArea() -> CGFloat {
        var sum: CGFloat = 0
        for i in 0..<self.count {
            let point1 = self[i]
            let point2 = self[(i + 1) % self.count]
            sum += (point2.x - point1.x) * (point2.y + point1.y)
        }
        return sum / 2.0
    }

    /// Calculates the area of the polygon formed by the points in the array.
    /// - Returns: The area of the polygon as a non-negative CGFloat.
    func area() -> CGFloat {
        return abs(signedArea())
    }

    /// Determines if the points in the array are ordered clockwise.
    /// - Note: This assumes inverted Y for CoreGraphics
    /// - Returns: A Boolean value indicating whether the points are ordered clockwise.
    func isClockwise() -> Bool {
        return signedArea() <= 0
    }
}

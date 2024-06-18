//
//  File.swift
//  
//
//  Created by Adam Wulf on 6/18/24.
//

import Foundation
import XCTest

class CGPointArrayExtensionsTests: XCTestCase {

    func testSortedClockwise() {
        let points = [CGPoint(x: 0, y: 0), CGPoint(x: 1, y: 0), CGPoint(x: 0, y: 1), CGPoint(x: 1, y: 1)]
        let sortedPoints = points.sortedClockwise()
        let expectedPoints = [CGPoint(x: 0, y: 0), CGPoint(x: 1, y: 0), CGPoint(x: 1, y: 1), CGPoint(x: 0, y: 1)]
        XCTAssertEqual(sortedPoints, expectedPoints)
    }

    func testSortClockwise() {
        var points = [CGPoint(x: 0, y: 0), CGPoint(x: 1, y: 0), CGPoint(x: 0, y: 1), CGPoint(x: 1, y: 1)]
        points.sortClockwise()
        let expectedPoints = [CGPoint(x: 0, y: 0), CGPoint(x: 1, y: 0), CGPoint(x: 1, y: 1), CGPoint(x: 0, y: 1)]
        XCTAssertEqual(points, expectedPoints)
    }

    func testSignedArea() {
        let points = [CGPoint(x: 0, y: 0), CGPoint(x: 1, y: 0), CGPoint(x: 1, y: 1), CGPoint(x: 0, y: 1)]
        let area = points.signedArea()
        XCTAssertEqual(area, -1.0)
    }

    func testArea() {
        let points = [CGPoint(x: 0, y: 0), CGPoint(x: 1, y: 0), CGPoint(x: 1, y: 1), CGPoint(x: 0, y: 1)]
        let area = points.area()
        XCTAssertEqual(area, 1.0)
    }

    func testIsClockwise() {
        let points = [CGPoint(x: 0, y: 0), CGPoint(x: 1, y: 0), CGPoint(x: 1, y: 1), CGPoint(x: 0, y: 1)]
        XCTAssertTrue(points.isClockwise())
    }
}

import XCTest
@testable import SwiftToolbox

final class SwiftToolboxTests: XCTestCase {

    static let epsilon: CGFloat = 0.00000000001

    func testCGRect() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(CGRect(x: 0, y: 0, width: 10, height: 10).expand(by: 2),
                       CGRect(x: -2, y: -2, width: 14, height: 14))
    }

    func testCGPointDiff() {
        let p1 = CGPoint(x: 1, y: 2)
        let p2 = CGPoint(x: 4, y: 3)
        let vec = p2 - p1
        XCTAssertEqual(vec, CGVector(dx: 3, dy: 1))
    }

    func testCGPointStep() {
        let p = CGPoint(x: 1, y: 2)
        let vec = CGVector(dx: 4, dy: 3)
        XCTAssertEqual(p + vec, CGPoint(x: 5, y: 5))
    }

    func testCGVectorTheta() {
        XCTAssertEqual(CGVector(dx: 1, dy: 0).theta, 0)
        XCTAssertEqual(CGVector(dx: 0, dy: 1).theta, CGFloat.pi / 2)
        XCTAssertEqual(CGVector(dx: 0, dy: -1).theta, -CGFloat.pi / 2)
        XCTAssertEqual(CGVector(dx: -1, dy: 0).theta, CGFloat.pi)
    }

    func testCGVectorMag() {
        XCTAssertEqual(CGVector(dx: 1, dy: 0).magnitude, 1)
        XCTAssertEqual(CGVector(dx: 1, dy: 1).magnitude, sqrt(2))
    }

    func testCGVectorNormalized() {
        XCTAssertEqual(CGVector(dx: 10, dy: 0).normalized.magnitude, 1)
        XCTAssertEqual(CGVector(dx: 10, dy: 4).normalized.magnitude, 1)
        XCTAssertEqual(CGVector(dx: 10, dy: 0).normalize(to: 3).magnitude, 3)
        XCTAssertEqual(CGVector(dx: 10, dy: 4).normalize(to: 3).magnitude, 3, accuracy: Self.epsilon)
    }

    func testStringTrim() {
        let str = "{ asdf }"
        let trimmed = "asdf"
        let trim1 = str.trimmingCharacters(in: CharacterSet(charactersIn: "{ }"))
        let trim2 = str.trimmingCharacters(in: CharacterSet(charactersIn: "{ }"))
        XCTAssertEqual(trim1, trimmed)
        XCTAssertEqual(trim2, trimmed)
    }

    func testSubstringRanges() {
        let str = """
                  asdf asdf asdf qwer qwer
                  pounqjkr;njg asdf rnw
                  """
        let ranges = str.ranges(of: "asdf")

        XCTAssertEqual(ranges.count, 4)
        XCTAssertEqual(ranges.first!.lowerBound, str.index(str.startIndex, offsetBy: 0))
        XCTAssertEqual(ranges.first!.upperBound, str.index(str.startIndex, offsetBy: 4))
        XCTAssertEqual(ranges.last!.lowerBound, str.index(str.startIndex, offsetBy: 38))
        XCTAssertEqual(ranges.last!.upperBound, str.index(str.startIndex, offsetBy: 42))
    }

    func testSubstringCount() {
        let str = """
                  asdf asdf asdf qwer qwer
                  pounqjkr;njg asdf rnw
                  """
        XCTAssertEqual(str.countOccurrences(of: "asdf"), 4)
        XCTAssertEqual(str.countOccurrences(of: "\n"), 1)
        XCTAssertEqual(str.countOccurrences(of: CharacterSet(charactersIn: "a\n")), 5)
    }
}

extension SwiftToolboxTests {
    static var allTests = [
        ("testCGRect", testCGRect),
        ("testCGPointDiff", testCGPointDiff),
        ("testCGPointStep", testCGPointStep),
        ("testCGVectorTheta", testCGVectorTheta),
        ("testCGVectorMag", testCGVectorMag),
        ("testCGVectorNormalized", testCGVectorNormalized)
    ]
}

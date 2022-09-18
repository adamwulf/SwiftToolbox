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

    func testSumDiffVectors() {
        let vec1 = CGVector(10, 20)
        let vec2 = CGVector(20, 10)

        XCTAssertEqual(vec1 - vec2, CGVector(-10, 10))
        XCTAssertEqual(vec2 - vec1, CGVector(10, -10))
        XCTAssertEqual(vec1 + vec2, CGVector(30, 30))
        XCTAssertEqual(vec2 + vec1, CGVector(30, 30))
    }

    func testMultVectorOrder() {
        let vec = CGVector(10, 20)

        XCTAssertEqual(vec * 4, CGVector(40, 80))
        XCTAssertEqual(4 * vec, CGVector(40, 80))
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

    func testArray() {
        struct Fumble: Equatable {
            let bump: Int
            let jump: Double
        }
        var arr: [Fumble] = [Fumble(bump: 1, jump: 20), Fumble(bump: 1, jump: 20), Fumble(bump: 4, jump: 20)]

        XCTAssertEqual(arr.count, 3)
        arr.remove(object: Fumble(bump: 1, jump: 20))
        XCTAssertEqual(arr.count, 1)
    }

    func testUniqueArray() {
        let arr = [1, 2, 3, 1, 1, 2, 5, 6, 7]
        let unique = arr.unique()

        XCTAssertEqual([1, 2, 3, 5, 6, 7], unique)
    }

    func testAddVectorToPoint() {
        var p = CGPoint(2, 3)
        var v = CGVector(1, 1)
        p += v
        XCTAssertEqual(p, CGPoint(3, 4))
        p -= v
        XCTAssertEqual(p, CGPoint(2, 3))
        v += v
        XCTAssertEqual(v, CGVector(2, 2))
        v -= v
        XCTAssertEqual(v, CGVector(0, 0))
    }

    func testDistanceToLine() {
        let p = CGPoint(50, 50)
        let l1 = CGPoint(0, 0)
        let l2 = CGPoint(0, 100)

        XCTAssertEqual(50, p.distance(to: CGLine(l1, l2)))
    }

    func testDistanceToLine2() {
        let p = CGPoint(1, 1)
        let l1 = CGPoint(-1, 1)
        let l2 = CGPoint(1, -1)

        XCTAssertEqual(sqrt(2), p.distance(to: CGLine(l1, l2)), accuracy: 0.0000001)
    }

    func testClosestOnLine() {
        let p = CGPoint(50, 50)
        let l1 = CGPoint(0, 0)
        let l2 = CGPoint(0, 100)

        let res = p.closestPoint(to: CGLine(l1, l2))
        XCTAssertEqual(res, CGPoint(0, 50))
    }

    func testClosestOnLine2() {
        let p = CGPoint(1, 1)
        let l1 = CGPoint(-1, 1)
        let l2 = CGPoint(1, -1)

        let res = p.closestPoint(to: CGLine(l1, l2))
        XCTAssertEqual(res.x, 0, accuracy: 0.0000001)
        XCTAssertEqual(res.y, 0, accuracy: 0.0000001)
    }

    func testDotProduct() {
        let v1 = CGVector(-6, 8)
        let v2 = CGVector(5, 12)

        XCTAssertEqual(v1 ⋅ v2, 66)
        XCTAssertEqual(v1.dot(v2), 66)
    }

    func testPower() {
        let num: CGFloat = 1.5

        XCTAssertEqual(num.squared(), 2.25)
        XCTAssertEqual(num.cubed(), 3.375)
        XCTAssertEqual(num.pow(4), 5.0625)
    }

    func testCountWhere() {
        let nums = [1, 5, 7, 4, 6, 32, 8, 0]
        XCTAssertEqual(nums.count(where: { $0 > 7 }), 2)
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

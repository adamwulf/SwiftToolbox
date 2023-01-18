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
        XCTAssertEqual(CGVector(dx: 10, dy: 0).unitVector.magnitude, 1)
        XCTAssertEqual(CGVector(dx: 10, dy: 4).unitVector.magnitude, 1)
        XCTAssertEqual(CGVector(dx: 10, dy: 0).scale(toLength: 3).magnitude, 3)
        XCTAssertEqual(CGVector(dx: 10, dy: 4).scale(toLength: 3).magnitude, 3, accuracy: Self.epsilon)
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

    func testDynamicProperties() {
        let (a, b) = (Object(), Object())

        XCTAssertNil(a.value)
        XCTAssertNil(b.value)

        a.value = 1
        b.value = 2

        XCTAssertEqual(a.value, 1)
        XCTAssertEqual(b.value, 2)
    }

    func testClamp() {
        XCTAssertEqual(30.clamp(to: 1...10), 10)
        XCTAssertEqual(30.clamp(to: 100...200), 100)
    }

    func testClampObj() {
        struct Fumble {
            @Clamped(1...10) var bumble: Int = 4
        }
        var something = Fumble()
        XCTAssertEqual(something.bumble, 4)
        something.bumble = 20
        XCTAssertEqual(something.bumble, 10)
        something.bumble = -20
        XCTAssertEqual(something.bumble, 1)
        something.bumble = 3
        XCTAssertEqual(something.bumble, 3)
    }

    @available(iOS 13.0, macOS 10.15, *)
    func testStringEscaping() {
        let str1 = "asdf1234"
        XCTAssertEqual(str1.slashEscape("s4"), "a\\sdf123\\4")
        let str2 = "asdf\n\"asdf"
        XCTAssertEqual(str2.slashEscape("\n\""), "asdf\\\n\\\"asdf")
        let str3 = "asdf\\as df"
        XCTAssertEqual(str3.slashEscape(" "), "asdf\\\\as\\ df")
    }

    @available(iOS 13.0, macOS 10.15, *)
    func testLogfmt() {
        class Fumble: CustomDebugStringConvertible {
            var debugDescription: String {
                return "debugStr"
            }
        }
        class Mumble: CustomStringConvertible {
            var description: String {
                return "customString"
            }
        }
        class Bumble: CustomLogfmtStringConvertible {
            var logfmtDescription: String {
                return "grumblebumble"
            }
        }
        let str1 = "asdf"
        XCTAssertEqual(String.logfmt(str1), "asdf")
        let str2 = "asdf\"asdf\""
        XCTAssertEqual(String.logfmt(str2), "\"asdf\\\"asdf\\\"\"")
        let num = 12
        XCTAssertEqual(String.logfmt(num), "12")
        let debugObj = Fumble()
        XCTAssertEqual(String.logfmt(debugObj), "debugStr")
        let descObj = Mumble()
        XCTAssertEqual(String.logfmt(descObj), "customString")
        let logfmtObj = Bumble()
        XCTAssertEqual(String.logfmt(logfmtObj), "grumblebumble")
        let arr1 = ["asdf", "qwer"]
        XCTAssertEqual(String.logfmt(arr1), "0=asdf 1=qwer")
        let arr2 = ["asdf", "qwer thjfdg"]
        XCTAssertEqual(String.logfmt(arr2), "0=asdf 1=\"qwer thjfdg\"")
        let dict1 = ["asdf": "qwer thjfdg"]
        XCTAssertEqual(String.logfmt(dict1), "asdf=\"qwer thjfdg\"")
        let dict2 = ["asdf": ["qwer thjfdg"]]
        XCTAssertEqual(String.logfmt(dict2), "asdf.0=\"qwer thjfdg\"")
        let dict3 = ["asdf": ["fumble": "qwer thjfdg"]]
        XCTAssertEqual(String.logfmt(dict3), "asdf.fumble=\"qwer thjfdg\"")

        let memoryContext = ["memory":
                                ["current": ["footprint": 128,
                                             "available": 2000 - 128,
                                             "limit": 2000],
                                 "peak": ["footprint": 348,
                                          "available": 2000 - 348,
                                          "limit": 2000]]]
        XCTAssertEqual(String.logfmt(memoryContext), ["memory.current.available=1872",
                                                         "memory.current.footprint=128",
                                                         "memory.current.limit=2000",
                                                         "memory.peak.available=1652",
                                                         "memory.peak.footprint=348",
                                                         "memory.peak.limit=2000"].joined(separator: " "))
    }

    func testContainsCharacters() {
        let str = "hello world"

        XCTAssertTrue(str.contains(charactersIn: "h"))
        XCTAssertTrue(str.contains(charactersIn: "he"))
        XCTAssertTrue(str.contains(charactersIn: "hel"))
        XCTAssertTrue(str.contains(charactersIn: "dlrow olleh"))

        XCTAssertFalse(str.contains(charactersIn: ""))
        XCTAssertFalse(str.contains(charactersIn: "z"))
        XCTAssertFalse(str.contains(charactersIn: "zxc"))
        XCTAssertFalse(str.contains(charactersIn: "zxvbnm"))
    }

    func testPlistEncoding() throws {
        let now = Date()
        let plist: [String: PropertyListCompatible] = ["data": Data([12, 13]),
                                      "string": "bumble",
                                      "int": 12,
                                      "double": 12.2,
                                      "date": now,
                                      "array": [1, 2, 3]]
        let plistData = try PropertyListSerialization.data(fromPropertyList: plist, format: .binary, options: 0)
        guard let readPlist = try PropertyListSerialization.propertyList(from: plistData, format: nil) as? [String: Any] else {
            XCTFail()
            return
        }

        XCTAssertEqual(readPlist["data"] as? Data, Data([12, 13]))
        XCTAssertEqual(readPlist["string"] as? String, "bumble")
        XCTAssertEqual(readPlist["int"] as? Int64, 12)
        XCTAssertEqual(readPlist["double"] as? Double, 12.2)
        XCTAssertEqual(readPlist["date"] as? Date, now)
        XCTAssertEqual(readPlist["array"] as? [Int], [1, 2, 3])
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

private class Object: DynamicProperties { }
extension Object {
    var value: Int? {
        get { return self[dynamic: #function] }
        set { self[dynamic: #function] = newValue }
    }
}

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

    func testTranslation() {
        let transform1 = CGAffineTransform(translationX: 10, y: 20)
        XCTAssertEqual(transform1.translation, CGPoint(x: 10, y: 20))

        let transform2 = CGAffineTransform(scaleX: 10, y: 20)
        XCTAssertEqual(transform2.translation, .zero)
    }

    func testScale() {
        let transform1 = CGAffineTransform(translationX: 10, y: 20)
        XCTAssertEqual(transform1.scale.x, 1.0)
        XCTAssertEqual(transform1.scale.y, 1.0)

        let transform2 = CGAffineTransform(scaleX: 10, y: 20)
        XCTAssertEqual(transform2.scale.x, 10.0)
        XCTAssertEqual(transform2.scale.y, 20.0)

        let transform3 = CGAffineTransform(scaleX: 20, y: 10)
        XCTAssertEqual(transform3.scale.x, 20.0)
        XCTAssertEqual(transform3.scale.y, 10.0)
    }

    func testRotation() {
        let transform = CGAffineTransform(rotationAngle: .pi / 2)
        XCTAssertEqual(transform.rotation, .pi / 2, accuracy: 0.0001)
        let transform2 = CGAffineTransform(rotationAngle: .pi)
        XCTAssertEqual(transform2.rotation, .pi, accuracy: 0.0001)
        let transform3 = CGAffineTransform(rotationAngle: .pi * 3 / 2)
        XCTAssertEqual(transform3.rotation, -.pi / 2, accuracy: 0.0001)
        let transform4 = CGAffineTransform(rotationAngle: .pi * 2)
        XCTAssertEqual(transform4.rotation, 0, accuracy: 0.0001)
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

    func testAbs() {
        XCTAssertEqual(CGFloat(-3).abs(), CGFloat(3))
        XCTAssertEqual(CGFloat(5).abs(), CGFloat(5))
        XCTAssertEqual(CGFloat(0).abs(), CGFloat(0))
    }

    func testSqrt() {
        XCTAssertEqual(CGFloat(9).sqrt(), CGFloat(3))
        XCTAssertEqual(CGFloat(4).sqrt(), CGFloat(2))
        XCTAssertEqual(CGFloat(0).sqrt(), CGFloat(0))
        XCTAssertNil(CGFloat(-4).sqrt())
    }

    func testRound() {
        XCTAssertEqual(CGFloat(4.5).round(), CGFloat(5))
        XCTAssertEqual(CGFloat(4.4).round(), CGFloat(4))
        XCTAssertEqual(CGFloat(-4.5).round(), CGFloat(-5))
        XCTAssertEqual(CGFloat(-4.6).round(), CGFloat(-5))
    }

    func testCeil() {
        XCTAssertEqual(CGFloat(4.1).ceil(), CGFloat(5))
        XCTAssertEqual(CGFloat(4.9).ceil(), CGFloat(5))
        XCTAssertEqual(CGFloat(-4.1).ceil(), CGFloat(-4))
        XCTAssertEqual(CGFloat(-4.9).ceil(), CGFloat(-4))
    }

    func testFloor() {
        XCTAssertEqual(CGFloat(4.1).floor(), CGFloat(4))
        XCTAssertEqual(CGFloat(4.9).floor(), CGFloat(4))
        XCTAssertEqual(CGFloat(-4.1).floor(), CGFloat(-5))
        XCTAssertEqual(CGFloat(-4.9).floor(), CGFloat(-5))
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
    func testStringEscaping2() {
        let str1 = "asdf1234"
        XCTAssertEqual(str1.slashEscape(.alphanumerics), "\\a\\s\\d\\f\\1\\2\\3\\4")
        let str2 = "asdf\n\"asdf"
        XCTAssertEqual(str2.slashEscape(.whitespacesAndNewlines), "asdf\\\n\"asdf")
        let str3 = "asdf\\as df"
        XCTAssertEqual(str3.slashEscape(.whitespaces), "asdf\\\\as\\ df")
    }

    func testTrimmingSuffixCharacters() {
        let string1 = "Hello, world!"
        let trimmed1 = string1.trimmingSuffixCharacters(in: .punctuationCharacters)
        XCTAssertEqual(trimmed1, "Hello, world")

        let string2 = "Swift is awesome!!!"
        let trimmed2 = string2.trimmingSuffixCharacters(in: .punctuationCharacters)
        XCTAssertEqual(trimmed2, "Swift is awesome")

        let string3 = "No suffix characters here"
        let trimmed3 = string3.trimmingSuffixCharacters(in: .punctuationCharacters)
        XCTAssertEqual(trimmed3, "No suffix characters here")

        let string4 = "!!!Hello, world!"
        let trimmed4 = string4.trimmingSuffixCharacters(in: .punctuationCharacters)
        XCTAssertEqual(trimmed4, "!!!Hello, world")

        let string5 = "!!!Swift is awesome!!!"
        let trimmed5 = string5.trimmingSuffixCharacters(in: .punctuationCharacters)
        XCTAssertEqual(trimmed5, "!!!Swift is awesome")

        let string6 = "!!!No suffix characters here!!!"
        let trimmed6 = string6.trimmingSuffixCharacters(in: .punctuationCharacters)
        XCTAssertEqual(trimmed6, "!!!No suffix characters here")
    }

    func testRemovingPrefix() {
        let string1 = "hello world"
        let string2 = "world"
        let string3 = "hello"
        let string4 = ""

        XCTAssertEqual(string1.removingPrefix("hello "), "world")
        XCTAssertEqual(string1.removingPrefix("world"), "hello world")
        XCTAssertEqual(string2.removingPrefix("hello "), "world")
        XCTAssertEqual(string3.removingPrefix("hello "), "hello")
        XCTAssertEqual(string4.removingPrefix(""), "")
    }

    func testRemovingSuffix() {
        let string1 = "hello world"
        let string2 = "world"
        let string3 = "hello"
        let string4 = ""

        XCTAssertEqual(string1.removingSuffix(" world"), "hello")
        XCTAssertEqual(string1.removingSuffix("hello"), "hello world")
        XCTAssertEqual(string2.removingSuffix(" world"), "world")
        XCTAssertEqual(string3.removingSuffix(" world"), "hello")
        XCTAssertEqual(string4.removingSuffix(" world"), "")
    }

    func testRemovePrefix() {
        var string1 = "hello world"
        var string2 = "world"
        var string3 = "hello"
        var string4 = ""

        string1.removePrefix("hello ")
        XCTAssertEqual(string1, "world")

        string2.removePrefix("hello ")
        XCTAssertEqual(string2, "world")

        string3.removePrefix("hello ")
        XCTAssertEqual(string3, "hello")

        string4.removePrefix("")
        XCTAssertEqual(string4, "")
    }

    func testRemoveSuffix() {
        var string1 = "hello world"
        var string2 = "world"
        var string3 = "hello"
        var string4 = ""

        string1.removeSuffix(" world")
        XCTAssertEqual(string1, "hello")

        string2.removeSuffix(" world")
        XCTAssertEqual(string2, "world")

        string3.removeSuffix(" world")
        XCTAssertEqual(string3, "hello")

        string4.removeSuffix(" world")
        XCTAssertEqual(string4, "")
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

    func testFilenameSafe() {
        let str = "Fancy String  with!@#$123"
        XCTAssertEqual(str.filenameSafe, "Fancy-String--with123")
    }

    func testByteSize() {
        let size = ByteSize.megabyte(3)
        XCTAssertEqual(size.humanReadable, "3.0 MB")
    }

    func testProcessInfo() {
        XCTAssert(ProcessInfo.isUnitTesting)
        XCTAssertGreaterThan(ProcessInfo.processInfo.memory!.current.limit, .megabyte(3))
    }

    func testMerging() {
        let dict1 = ["a": 1, "b": 2, "c": 3]
        let dict2 = ["b": 4, "d": 5]
        let mergedDict = dict1.merging(dict2)
        XCTAssertEqual(mergedDict, ["a": 1, "b": 2, "c": 3, "d": 5])
    }

    func testMapValues() {
        let dict = ["a": 1, "b": 2, "c": 3]
        let transformedDict = dict.mapValues { _, value in
            return value * 2
        }
        XCTAssertEqual(transformedDict, ["a": 2, "b": 4, "c": 6])
    }

    func testMapKeys() {
        let dictionary = ["apple": 1, "banana": 2, "orange": 3]

        let transformedDictionary = dictionary.mapKeys { key, _ in
            return key.uppercased()
        }

        XCTAssertEqual(transformedDictionary, ["APPLE": 1, "BANANA": 2, "ORANGE": 3])
    }

    func testCompactMapValues() {
        let dict = ["a": 1, "b": 2, "c": 3]
        let transformedDict = dict.compactMapValues { _, value in
            return value % 2 == 0 ? value * 2 : nil
        }
        XCTAssertEqual(transformedDict, ["b": 4])
    }

#if canImport(UIKit)
    func testLayoutPriority() {
        let required: UILayoutPriority = .required
        let less = required.lower()
        let more = required.higher()
        let evenLess = less.lower()
        let moreAgain = evenLess.higher()

        XCTAssertEqual(required, more)
        XCTAssertGreaterThan(more, less)
        XCTAssertGreaterThan(less, evenLess)
        XCTAssertEqual(moreAgain, less)
    }
#endif
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

import XCTest
@testable import MMSwiftToolbox

final class MMSwiftToolboxTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(MMSwiftToolbox().text, "Hello, World!")
    }

    func testCGRect() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(CGRect(x: 0, y: 0, width: 10, height: 10).expand(by: 2),
                       CGRect(x: -2, y: -2, width: 14, height: 14))
    }

    func testCGPoint() {
        let p1 = CGPoint(x: 1, y: 2)
        let p2 = CGPoint(x: 4, y: 3)
        let vec = p2 - p1
        XCTAssertEqual(vec, CGVector(dx: 3, dy: 1))
    }

    static var allTests = [
        ("testExample", testExample),
        ("testCGRect", testCGRect),
        ("testCGPoint", testCGPoint)
    ]
}

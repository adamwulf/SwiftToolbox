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

    static var allTests = [
        ("testExample", testExample),
        ("testCGRect", testCGRect),
    ]
}

import XCTest
@testable import SwiftToolbox

final class FormDataTests: XCTestCase {

    func testParseMultipartFormDataWithTextFields() {
        let fileContent = """
        --4250D4D6-2C1D-4602-A004-64D839E45169
        Content-Disposition: form-data; name="uuid"

        4250D4D6-2C1D-4602-A004-64D839E45169
        --4250D4D6-2C1D-4602-A004-64D839E45169
        Content-Disposition: form-data; name="title"

        DuckDuckGo ‚Äî Privacy, simplified.
        --4250D4D6-2C1D-4602-A004-64D839E45169--
        """

        if let result = FormData.parseMultipartFormData(from: fileContent) {
            XCTAssertEqual(result.boundary, "4250D4D6-2C1D-4602-A004-64D839E45169")
            XCTAssertEqual(result.formData.count, 2)

            let uuidField = result.formData[0]
            XCTAssertEqual(uuidField.name, "uuid")
            XCTAssertNil(uuidField.filename)
            XCTAssertEqual(String(data: uuidField.value, encoding: .utf8), "4250D4D6-2C1D-4602-A004-64D839E45169\n")

            let titleField = result.formData[1]
            XCTAssertEqual(titleField.name, "title")
            XCTAssertNil(titleField.filename)
            XCTAssertEqual(String(data: titleField.value, encoding: .utf8), "DuckDuckGo ‚Äî Privacy, simplified.\n")
        } else {
            XCTFail("Failed to parse multipart form data")
        }
    }

    func testParseMultipartFormDataWithBinaryData() {
        guard let fileURL = Bundle.module.url(forResource: "example", withExtension: "png"),
              let fileData = try? Data(contentsOf: fileURL) else {
            XCTFail("Failed to load example.png from test bundle")
            return
        }

        let fileContent = """
            --4250D4D6-2C1D-4602-A004-64D839E45169
            Content-Disposition: form-data; name="binary_data"; filename="example.png"
            Content-Type: image/png

            \(fileData.base64EncodedString())
            --4250D4D6-2C1D-4602-A004-64D839E45169--
            """

        if let result = FormData.parseMultipartFormData(from: fileContent) {
            XCTAssertEqual(result.boundary, "4250D4D6-2C1D-4602-A004-64D839E45169")
            XCTAssertEqual(result.formData.count, 1)

            let binaryField = result.formData[0]
            XCTAssertEqual(binaryField.name, "binary_data")
            XCTAssertEqual(binaryField.filename, "example.png")
            XCTAssertEqual(binaryField.contentType, "image/png")
            XCTAssertEqual(binaryField.value, fileData)
        } else {
            XCTFail("Failed to parse multipart form data")
        }
    }

    func testParseMultipartFormDataWithJsonData() {
        let fileContent = """
        --91959998-92F6-4D5E-B1EB-559175C0649A
        Content-Disposition: form-data; name="json_data"
        Content-Type: application/json

        {
          "url" : "https:\\/\\/duckduckgo.com\\/"
        }
        --91959998-92F6-4D5E-B1EB-559175C0649A--
        """

        if let result = FormData.parseMultipartFormData(from: fileContent) {
            XCTAssertEqual(result.boundary, "91959998-92F6-4D5E-B1EB-559175C0649A")
            XCTAssertEqual(result.formData.count, 1)

            let jsonField = result.formData[0]
            XCTAssertEqual(jsonField.name, "json_data")
            XCTAssertNil(jsonField.filename)
            XCTAssertEqual(jsonField.contentType, "application/json")
            XCTAssertEqual(String(data: jsonField.value, encoding: .utf8), "{\n  \"url\" : \"https:\\/\\/duckduckgo.com\\/\"\n}\n")
        } else {
            XCTFail("Failed to parse multipart form data")
        }
    }

    // Test that a form value that contains form-data formatted content is still able to be parsed.
    func testParseMultipartFormDataWithNestedFormData() {
        let nestedFormData = """
            --nestedBoundary
            Content-Disposition: form-data; name="nestedField"

            nestedValue
            --nestedBoundary--
            """

        let fileContent = """
            --4250D4D6-2C1D-4602-A004-64D839E45169
            Content-Disposition: form-data; name="nested_form_data"
            Content-Type: multipart/form-data; boundary=nestedBoundary

            \(nestedFormData)
            --4250D4D6-2C1D-4602-A004-64D839E45169--
            """

        if let result = FormData.parseMultipartFormData(from: fileContent) {
            XCTAssertEqual(result.boundary, "4250D4D6-2C1D-4602-A004-64D839E45169")
            XCTAssertEqual(result.formData.count, 1)

            let nestedField = result.formData[0]
            XCTAssertEqual(nestedField.name, "nested_form_data")
            XCTAssertNil(nestedField.filename)
            XCTAssertEqual(nestedField.contentType, "multipart/form-data; boundary=nestedBoundary")
            XCTAssertEqual(String(data: nestedField.value, encoding: .utf8), nestedFormData + "\n")
        } else {
            XCTFail("Failed to parse multipart form data")
        }
    }
}

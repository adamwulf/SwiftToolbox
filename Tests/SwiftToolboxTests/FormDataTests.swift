import XCTest
@testable import SwiftToolbox

final class FormDataTests: XCTestCase {

    func testRequireCarraigeReturn1() {
        let fileContent = """
        line1
        line2
        line3
        line4
        line5
        line6
        """

        let processed = [
            fileContent
        ]

        let lines = FormData.processLines(in: Data(fileContent.utf8)).map({ String(data: $0, encoding: .utf8)! })
        XCTAssertEqual(lines, processed)
    }

    func testRequireCarraigeReturn2() {
        let fileContent = """
        line1\r
        line2\r
        line3\r
        line4\r
        line5\r
        line6
        """

        let processed = [
            "line1",
            "line2",
            "line3",
            "line4",
            "line5",
            "line6",
        ]

        let lines = FormData.processLines(in: Data(fileContent.utf8)).map({ String(data: $0, encoding: .utf8)! })
        XCTAssertEqual(lines, processed)
    }

    func testRequireCarraigeReturn3() {
        let fileContent = """
        line1\r
        line2\r
        line3
        line4\r
        line5\r
        line6
        """

        let processed = [
            "line1",
            "line2",
            "line3\nline4",
            "line5",
            "line6",
        ]

        let lines = FormData.processLines(in: Data(fileContent.utf8)).map({ String(data: $0, encoding: .utf8)! })
        XCTAssertEqual(lines, processed)
    }

    func testRequireCarraigeReturn4() {
        let fileContent = """
        line1\r
        line2\r
        \r
        line4\r
        line5\r
        line6
        """

        let processed = [
            "line1",
            "line2",
            "",
            "line4",
            "line5",
            "line6",
        ]

        let lines = FormData.processLines(in: Data(fileContent.utf8)).map({ String(data: $0, encoding: .utf8)! })
        XCTAssertEqual(lines, processed)
    }

    func testTextFields() {
        let fileContent = """
        --4250D4D6-2C1D-4602-A004-64D839E45169\r
        Content-Disposition: form-data; name="uuid"\r
        \r
        4250D4D6-2C1D-4602-A004-64D839E45169\r
        --4250D4D6-2C1D-4602-A004-64D839E45169\r
        Content-Disposition: form-data; name="title"\r
        \r
        DuckDuckGo ‚Äî Privacy, simplified.\r
        --4250D4D6-2C1D-4602-A004-64D839E45169--
        """

        if let result = FormData.parseMultipartFormData(from: Data(fileContent.utf8)) {
            XCTAssertEqual(result.boundary, "4250D4D6-2C1D-4602-A004-64D839E45169")
            guard result.formData.count == 2 else {
                XCTFail()
                return
            }

            let uuidField = result.formData[0]
            XCTAssertEqual(uuidField.name, "uuid")
            XCTAssertNil(uuidField.filename)
            XCTAssertEqual(String(data: uuidField.value, encoding: .utf8), "4250D4D6-2C1D-4602-A004-64D839E45169")

            let titleField = result.formData[1]
            XCTAssertEqual(titleField.name, "title")
            XCTAssertNil(titleField.filename)
            XCTAssertEqual(String(data: titleField.value, encoding: .utf8), "DuckDuckGo ‚Äî Privacy, simplified.")
        } else {
            XCTFail("Failed to parse multipart form data")
        }
    }

    func testBinaryData() {
        guard let fileURL = Bundle.module.url(forResource: "example", withExtension: "png"),
              let fileData = try? Data(contentsOf: fileURL) else {
            XCTFail("Failed to load example.png from test bundle")
            return
        }

        let fileContent = """
            --4250D4D6-2C1D-4602-A004-64D839E45169\r
            Content-Disposition: form-data; name="title"\r
            \r
            DuckDuckGo — Privacy, simplified.\r
            --4250D4D6-2C1D-4602-A004-64D839E45169--\r
            Content-Disposition: form-data; name="binary_data"; filename="example.png"\r
            Content-Type: image/png\r
            \r
            \(fileData.base64EncodedString())\r
            --4250D4D6-2C1D-4602-A004-64D839E45169--
            """

        if let result = FormData.parseMultipartFormData(from: Data(fileContent.utf8)) {
            XCTAssertEqual(result.boundary, "4250D4D6-2C1D-4602-A004-64D839E45169")
            guard result.formData.count == 2 else {
                XCTFail()
                return
            }

            let titleField = result.formData[0]
            XCTAssertEqual(titleField.name, "title")
            XCTAssertNil(titleField.filename)
            XCTAssertEqual(String(data: titleField.value, encoding: .utf8), "DuckDuckGo — Privacy, simplified.")

            let binaryField = result.formData[1]
            XCTAssertEqual(binaryField.name, "binary_data")
            XCTAssertEqual(binaryField.filename, "example.png")
            XCTAssertEqual(binaryField.contentType, "image/png")
            XCTAssertEqual(binaryField.value, fileData)
        } else {
            XCTFail("Failed to parse multipart form data")
        }
    }

    func testBinaryData2() {
        guard let fileURL = Bundle.module.url(forResource: "F23A9777-B637-42E1-89AA-3ABDDD5FF88A", withExtension: "request_data"),
              let fileData = try? Data(contentsOf: fileURL) else {
            XCTFail("Failed to load example.png from test bundle")
            return
        }

        if let result = FormData.parseMultipartFormData(from: fileData) {
            XCTAssertEqual(result.boundary, "F23A9777-B637-42E1-89AA-3ABDDD5FF88A")
            guard result.formData.count == 3 else {
                XCTFail()
                return
            }

            let uuidField = result.formData[0]
            XCTAssertEqual(uuidField.name, "uuid")
            XCTAssertNil(uuidField.filename)
            XCTAssertEqual(String(data: uuidField.value, encoding: .utf8), "F23A9777-B637-42E1-89AA-3ABDDD5FF88A")

            let titleField = result.formData[1]
            XCTAssertEqual(titleField.name, "title")
            XCTAssertNil(titleField.filename)
            XCTAssertEqual(String(data: titleField.value, encoding: .utf8), "")

            let jsonField = result.formData[2]
            XCTAssertEqual(jsonField.name, "json_data")
            XCTAssertNil(jsonField.filename)
            XCTAssertEqual(String(data: jsonField.value, encoding: .utf8), "{\n  \"text\" : \"Test\"\n}")
        } else {
            XCTFail("Failed to parse multipart form data")
        }
    }

    func testRawBinaryData() {
        guard let fileURL = Bundle.module.url(forResource: "example", withExtension: "png"),
              let fileData = try? Data(contentsOf: fileURL) else {
            XCTFail("Failed to load example.png from test bundle")
            return
        }

        var fileContent = Data()
        let boundary = "--4250D4D6-2C1D-4602-A004-64D839E45169"
        let headers = """
        Content-Disposition: form-data; name="binary_data"; filename="example.png"\r
        Content-Type: image/png\r

        """.data(using: .utf8)!

        fileContent.append(Data(boundary.utf8))
        fileContent.append(Data("\r\n".utf8))
        fileContent.append(headers)
        fileContent.append(Data("\r\n".utf8))
        fileContent.append(fileData)
        fileContent.append(Data("\r\n".utf8))
        fileContent.append(Data(boundary.utf8))
        fileContent.append(Data("--".utf8))

        if let result = FormData.parseMultipartFormData(from: fileContent) {
            XCTAssertEqual(result.boundary, "4250D4D6-2C1D-4602-A004-64D839E45169")
            guard result.formData.count == 1 else {
                XCTFail()
                return
            }

            let binaryField = result.formData[0]
            XCTAssertEqual(binaryField.name, "binary_data")
            XCTAssertEqual(binaryField.filename, "example.png")
            XCTAssertEqual(binaryField.contentType, "image/png")
            XCTAssertEqual(binaryField.value, fileData)
        } else {
            XCTFail("Failed to parse multipart form data")
        }
    }

    func testJsonData() {
        let fileContent = """
        --91959998-92F6-4D5E-B1EB-559175C0649A\r
        Content-Disposition: form-data; name="json_data"\r
        Content-Type: application/json\r
        \r
        {
          "url" : "https:\\/\\/duckduckgo.com\\/"
        }\r
        --91959998-92F6-4D5E-B1EB-559175C0649A--
        """

        if let result = FormData.parseMultipartFormData(from: Data(fileContent.utf8)) {
            XCTAssertEqual(result.boundary, "91959998-92F6-4D5E-B1EB-559175C0649A")
            guard result.formData.count == 1 else {
                XCTFail()
                return
            }

            let jsonField = result.formData[0]
            XCTAssertEqual(jsonField.name, "json_data")
            XCTAssertNil(jsonField.filename)
            XCTAssertEqual(jsonField.contentType, "application/json")
            XCTAssertEqual(String(data: jsonField.value, encoding: .utf8), "{\n  \"url\" : \"https:\\/\\/duckduckgo.com\\/\"\n}")
        } else {
            XCTFail("Failed to parse multipart form data")
        }
    }

    // Test that a form value that contains form-data formatted content is still able to be parsed.
    func testNestedFormData() {
        let nestedFormData = """
            --nestedBoundary\r
            Content-Disposition: form-data; name="nestedField"\r
            \r
            nestedValue\r
            --nestedBoundary--
            """

        let fileContent = """
            --4250D4D6-2C1D-4602-A004-64D839E45169\r
            Content-Disposition: form-data; name="nested_form_data"\r
            Content-Type: multipart/form-data; boundary=nestedBoundary\r
            \r
            \(nestedFormData)\r
            --4250D4D6-2C1D-4602-A004-64D839E45169--
            """

        if let result = FormData.parseMultipartFormData(from: Data(fileContent.utf8)) {
            XCTAssertEqual(result.boundary, "4250D4D6-2C1D-4602-A004-64D839E45169")
            guard result.formData.count == 1 else {
                XCTFail()
                return
            }

            let nestedField = result.formData[0]
            XCTAssertEqual(nestedField.name, "nested_form_data")
            XCTAssertNil(nestedField.filename)
            XCTAssertEqual(nestedField.contentType, "multipart/form-data; boundary=nestedBoundary")
            XCTAssertEqual(String(data: nestedField.value, encoding: .utf8), nestedFormData)
        } else {
            XCTFail("Failed to parse multipart form data")
        }
    }

    func testCarraigeReturns() {
        guard
            let fileURL = Bundle.module.url(forResource: "4250D4D6-2C1D-4602-A004-64D839E45169", withExtension: "request_data"),
            let fileData = try? Data(contentsOf: fileURL)
        else {
            XCTFail("Failed to load example.png from test bundle")
            return
        }

        if let result = FormData.parseMultipartFormData(from: fileData) {
            XCTAssertEqual(result.boundary, "4250D4D6-2C1D-4602-A004-64D839E45169")
            guard result.formData.count == 3 else {
                XCTFail()
                return
            }

            let uuidField = result.formData[0]
            XCTAssertEqual(uuidField.name, "uuid")
            XCTAssertNil(uuidField.filename)
            XCTAssertEqual(String(data: uuidField.value, encoding: .utf8), "4250D4D6-2C1D-4602-A004-64D839E45169")

            let titleField = result.formData[1]
            XCTAssertEqual(titleField.name, "title")
            XCTAssertNil(titleField.filename)
            XCTAssertEqual(String(data: titleField.value, encoding: .utf8), "DuckDuckGo — Privacy, simplified.")

            let binaryField = result.formData[2]
            XCTAssertEqual(binaryField.name, "binary_data")
            XCTAssertEqual(binaryField.filename, "DuckDuckGo — Privacy, simplified..pdf")
            XCTAssertEqual(binaryField.value.count, 2462905)
        } else {
            XCTFail("Failed to parse multipart form data")
        }
    }

    func testCarraigeReturns2() {
        guard
            let fileURL = Bundle.module.url(forResource: "91959998-92F6-4D5E-B1EB-559175C0649A", withExtension: "request_data"),
            let fileData = try? Data(contentsOf: fileURL)
        else {
            XCTFail("Failed to load example.png from test bundle")
            return
        }

        if let result = FormData.parseMultipartFormData(from: fileData) {
            XCTAssertEqual(result.boundary, "91959998-92F6-4D5E-B1EB-559175C0649A")
            guard result.formData.count == 3 else {
                XCTFail()
                return
            }

            let uuidField = result.formData[0]
            XCTAssertEqual(uuidField.name, "uuid")
            XCTAssertNil(uuidField.filename)
            XCTAssertEqual(String(data: uuidField.value, encoding: .utf8), "91959998-92F6-4D5E-B1EB-559175C0649A")

            let titleField = result.formData[1]
            XCTAssertEqual(titleField.name, "title")
            XCTAssertNil(titleField.filename)
            XCTAssertEqual(String(data: titleField.value, encoding: .utf8), "")

            let jsonField = result.formData[2]
            XCTAssertEqual(jsonField.name, "json_data")
            XCTAssertNil(jsonField.filename)
            XCTAssertNil(jsonField.contentType)
            // This looks strange with the extra \r\n at the end, but this is how the data is formatted in the file and is the correct parse
            XCTAssertEqual(String(data: jsonField.value, encoding: .utf8), "{\n  \"url\" : \"https:\\/\\/duckduckgo.com\\/\"\n}\r\n")
        } else {
            XCTFail("Failed to parse multipart form data")
        }
    }

    func testCarraigeReturns3() {
        guard
            let fileURL = Bundle.module.url(forResource: "6C3CBA59-4B5F-4ADF-BEC7-080210848D1B", withExtension: "request_data"),
            let fileData = try? Data(contentsOf: fileURL)
        else {
            XCTFail("Failed to load example.png from test bundle")
            return
        }

        if let result = FormData.parseMultipartFormData(from: fileData) {
            XCTAssertEqual(result.boundary, "6C3CBA59-4B5F-4ADF-BEC7-080210848D1B")
            guard result.formData.count == 3 else {
                XCTFail()
                return
            }

            let uuidField = result.formData[0]
            XCTAssertEqual(uuidField.name, "uuid")
            XCTAssertNil(uuidField.filename)
            XCTAssertEqual(String(data: uuidField.value, encoding: .utf8), "6C3CBA59-4B5F-4ADF-BEC7-080210848D1B")

            let titleField = result.formData[1]
            XCTAssertEqual(titleField.name, "title")
            XCTAssertNil(titleField.filename)
            XCTAssertEqual(String(data: titleField.value, encoding: .utf8), "DuckDuckGo — Privacy, simplified.")

            let binaryField = result.formData[2]
            XCTAssertEqual(binaryField.name, "binary_data")
            XCTAssertEqual(binaryField.filename, "DuckDuckGo — Privacy, simplified..pdf")
            XCTAssertEqual(binaryField.value.count, 2797050)
        } else {
            XCTFail("Failed to parse multipart form data")
        }
    }

    func testMaxBinarySize() {
        guard let fileURL = Bundle.module.url(forResource: "F23A9777-B637-42E1-89AA-3ABDDD5FF88A", withExtension: "request_data"),
              let fileData = try? Data(contentsOf: fileURL) else {
            XCTFail("Failed to load example.png from test bundle")
            return
        }

        if let result = FormData.parseMultipartFormData(from: fileData, maxValueSize: .megabyte(1)) {
            XCTAssertEqual(result.boundary, "F23A9777-B637-42E1-89AA-3ABDDD5FF88A")
            guard result.formData.count == 3 else {
                XCTFail()
                return
            }

            let uuidField = result.formData[0]
            XCTAssertEqual(uuidField.name, "uuid")
            XCTAssertNil(uuidField.filename)
            XCTAssertEqual(String(data: uuidField.value, encoding: .utf8), "F23A9777-B637-42E1-89AA-3ABDDD5FF88A")

            let titleField = result.formData[1]
            XCTAssertEqual(titleField.name, "title")
            XCTAssertNil(titleField.filename)
            XCTAssertEqual(String(data: titleField.value, encoding: .utf8), "")

            let jsonField = result.formData[2]
            XCTAssertEqual(jsonField.name, "json_data")
            XCTAssertNil(jsonField.filename)
            XCTAssertEqual(String(data: jsonField.value, encoding: .utf8), "{\n  \"text\" : \"Test\"\n}")
        } else {
            XCTFail("Failed to parse multipart form data")
        }
    }

    func testMaxBinarySize2() {
        guard let fileURL = Bundle.module.url(forResource: "F23A9777-B637-42E1-89AA-3ABDDD5FF88A", withExtension: "request_data"),
              let fileData = try? Data(contentsOf: fileURL) else {
            XCTFail("Failed to load example.png from test bundle")
            return
        }

        if let result = FormData.parseMultipartFormData(from: fileData, maxValueSize: .byte(30)) {
            XCTAssertEqual(result.boundary, "F23A9777-B637-42E1-89AA-3ABDDD5FF88A")
            guard result.formData.count == 3 else {
                XCTFail()
                return
            }

            let uuidField = result.formData[0]
            XCTAssertEqual(uuidField.name, "uuid")
            XCTAssertNil(uuidField.filename)
            XCTAssertEqual(String(data: uuidField.value, encoding: .utf8), "")

            let titleField = result.formData[1]
            XCTAssertEqual(titleField.name, "title")
            XCTAssertNil(titleField.filename)
            XCTAssertEqual(String(data: titleField.value, encoding: .utf8), "")

            let jsonField = result.formData[2]
            XCTAssertEqual(jsonField.name, "json_data")
            XCTAssertNil(jsonField.filename)
            XCTAssertEqual(String(data: jsonField.value, encoding: .utf8), "{\n  \"text\" : \"Test\"\n}")
        } else {
            XCTFail("Failed to parse multipart form data")
        }
    }

    func testMaxBinarySize3() {
        guard let fileURL = Bundle.module.url(forResource: "F23A9777-B637-42E1-89AA-3ABDDD5FF88A", withExtension: "request_data"),
              let fileData = try? Data(contentsOf: fileURL) else {
            XCTFail("Failed to load example.png from test bundle")
            return
        }

        if let result = FormData.parseMultipartFormData(from: fileData, maxValueSize: .zero) {
            XCTAssertEqual(result.boundary, "F23A9777-B637-42E1-89AA-3ABDDD5FF88A")
            guard result.formData.count == 3 else {
                XCTFail()
                return
            }

            let uuidField = result.formData[0]
            XCTAssertEqual(uuidField.name, "uuid")
            XCTAssertNil(uuidField.filename)
            XCTAssertEqual(String(data: uuidField.value, encoding: .utf8), "")

            let titleField = result.formData[1]
            XCTAssertEqual(titleField.name, "title")
            XCTAssertNil(titleField.filename)
            XCTAssertEqual(String(data: titleField.value, encoding: .utf8), "")

            let jsonField = result.formData[2]
            XCTAssertEqual(jsonField.name, "json_data")
            XCTAssertNil(jsonField.filename)
            XCTAssertEqual(String(data: jsonField.value, encoding: .utf8), "")
        } else {
            XCTFail("Failed to parse multipart form data")
        }
    }

    func testMaxBinarySize4() {
        guard let fileURL = Bundle.module.url(forResource: "6C3CBA59-4B5F-4ADF-BEC7-080210848D1B", withExtension: "request_data"),
              let fileData = try? Data(contentsOf: fileURL) else {
            XCTFail("Failed to load example.png from test bundle")
            return
        }

        if let result = FormData.parseMultipartFormData(from: fileData, maxValueSize: .megabyte(1)) {
            XCTAssertEqual(result.boundary, "6C3CBA59-4B5F-4ADF-BEC7-080210848D1B")
            guard result.formData.count == 3 else {
                XCTFail()
                return
            }

            let uuidField = result.formData[0]
            XCTAssertEqual(uuidField.name, "uuid")
            XCTAssertNil(uuidField.filename)
            XCTAssertEqual(String(data: uuidField.value, encoding: .utf8), "6C3CBA59-4B5F-4ADF-BEC7-080210848D1B")

            let titleField = result.formData[1]
            XCTAssertEqual(titleField.name, "title")
            XCTAssertNil(titleField.filename)
            XCTAssertEqual(String(data: titleField.value, encoding: .utf8), "DuckDuckGo — Privacy, simplified.")

            let binaryField = result.formData[2]
            XCTAssertEqual(binaryField.name, "binary_data")
            XCTAssertEqual(binaryField.filename, "DuckDuckGo — Privacy, simplified..pdf")
            XCTAssertEqual(binaryField.value.count, 0)
        } else {
            XCTFail("Failed to parse multipart form data")
        }
    }

}

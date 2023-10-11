import XCTest

@testable import Wildfront

/// Tests the data extensions functions.
class DataExtensionsTests: XCTestCase {
    /// Testing that the pretty printed JSON is working as expected.
    func testPrettyPrintedJSONStringValidData() {
        let validData = """
        {
            "name": "Phil C",
            "age": 34,
            "city": "Philadelphia"
        }
        """.data(using: .utf8)!

        XCTAssertNotNil(validData.prettyPrintedJSONString())
    }

    /// Testing that the json is not valid and fails correctly.
    func testPrettyPrintedJSONStringInvalidData() {
        let invalidData = Data()
        let prettyPrintedJSON = invalidData.prettyPrintedJSONString()
        XCTAssertNil(prettyPrintedJSON)
    }

    /// Testing with nested json.
    func testPrettyPrintedJSONStringNestedJSON() {
        let nestedJSONData = """
        {
            "person": {
                "name": "Jane Smith",
                "age": 25
            }
        }
        """.data(using: .utf8)!

        XCTAssertNotNil(nestedJSONData.prettyPrintedJSONString())
    }
}

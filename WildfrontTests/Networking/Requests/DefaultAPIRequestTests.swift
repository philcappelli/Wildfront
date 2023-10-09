import XCTest

@testable import Wildfront

class APIRequestTests: XCTestCase {

    func testDefaultAPIRequestProperties() {
        let request = DefaultAPIRequest()

        // Test base URL
        XCTAssertNotNil(request.baseURL, "DefaultAPIRequest baseURL should not be nil")

        // Test headers
        XCTAssertNotNil(request.headers, "DefaultAPIRequest headers should not be nil")

        // Test method
        XCTAssertEqual(request.method, .get, "DefaultAPIRequest method should be GET")

        // Test parameters
        XCTAssertNil(request.parameters, "DefaultAPIRequest parameters should be nil")
    }

    func testNationalParksRequestPath() {
        let request = NationalParksRequest()

        // Test path
        XCTAssertEqual(request.path, "parks", "NationalParksRequest path should be 'parks'")
    }
}

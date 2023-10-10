import XCTest

@testable import Wildfront

class APIRequestTests: XCTestCase {
    func testDefaultAPIRequestProperties() {
        let request = DefaultAPIRequest()
        XCTAssertNotNil(request.baseURL, "DefaultAPIRequest baseURL should not be nil")
        XCTAssertNotNil(request.headers, "DefaultAPIRequest headers should not be nil")
        XCTAssertEqual(request.method, .get, "DefaultAPIRequest method should be GET")
        XCTAssertNil(request.parameters, "DefaultAPIRequest parameters should be nil")
    }

    func testNationalParksRequestPath() {
        let request = NationalParksRequest()
        XCTAssertEqual(request.path, "parks", "NationalParksRequest path should be 'parks'")
    }
}

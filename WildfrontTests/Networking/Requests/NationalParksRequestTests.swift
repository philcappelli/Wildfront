import XCTest

@testable import Wildfront

class NationalParksRequestTests: XCTestCase {
    /// Tests that the request path is correct.
    func testNationalParksRequestPath() {
        let request = NationalParksRequest()
        XCTAssertEqual(request.path, "parks")
    }
}

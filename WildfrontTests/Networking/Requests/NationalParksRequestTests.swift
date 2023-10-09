import XCTest

@testable import Wildfront

class NationalParksRequestTests: XCTestCase {
    func testNationalParksRequestPath() {
        let request = NationalParksRequest()
        XCTAssertEqual(request.path, "parks")
    }
}

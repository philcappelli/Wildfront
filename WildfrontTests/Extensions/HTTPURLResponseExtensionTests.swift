import XCTest

/// Unit tests for the HTTPURLResponse extension to check if it correctly identifies HTTP status codes.
/// 
class HTTPURLResponseTests: XCTestCase {
    /// Test if the HTTPURLResponse correctly identifies a success status code.
    func testHasStatusCodeSuccess() {
        let response = HTTPURLResponse(
            url: URL(string: "https://example.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        XCTAssertTrue(response?.hasStatusCode(.success) ?? false)
    }

    /// Test if the HTTPURLResponse correctly identifies a redirection status code.
    func testHasStatusCodeRedirection() {
        let response = HTTPURLResponse(
            url: URL(string: "https://example.com")!,
            statusCode: 301,
            httpVersion: nil,
            headerFields: nil
        )
        XCTAssertTrue(response?.hasStatusCode(.redirection) ?? false)
    }

    /// Test if the HTTPURLResponse correctly identifies a client error status code.
    func testHasStatusCodeClientError() {
        let response = HTTPURLResponse(
            url: URL(string: "https://example.com")!,
            statusCode: 403,
            httpVersion: nil,
            headerFields: nil
        )
        XCTAssertTrue(response?.hasStatusCode(.clientError) ?? false)
    }

    /// Test if the HTTPURLResponse correctly identifies a server error status code.
    func testHasStatusCodeServerError() {
        let response = HTTPURLResponse(
            url: URL(string: "https://example.com")!,
            statusCode: 500,
            httpVersion: nil,
            headerFields: nil
        )
        XCTAssertTrue(response?.hasStatusCode(.serverError) ?? false)
    }

    /// Test if the HTTPURLResponse correctly identifies a non-matching status code.
    func testHasStatusCodeNonMatching() {
        let response = HTTPURLResponse(
            url: URL(string: "https://example.com")!,
            statusCode: 600, // An arbitrary status code that doesn't match any enum case
            httpVersion: nil,
            headerFields: nil
        )
        XCTAssertFalse(response?.hasStatusCode(.success) ?? false)
        XCTAssertFalse(response?.hasStatusCode(.redirection) ?? false)
        XCTAssertFalse(response?.hasStatusCode(.clientError) ?? false)
        XCTAssertFalse(response?.hasStatusCode(.serverError) ?? false)
    }
}

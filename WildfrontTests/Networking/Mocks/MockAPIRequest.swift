import Foundation

@testable import Wildfront

// Mock implementation of APIRequest for testing purposes.
struct MockAPIRequest: APIRequest {
    /// Provide a mock base URL.
    var baseURL: URL {
        URL(string: "https://example.com")!
    }

    /// Provide a mock path.
    var path: String {
        "/mockEndpoint"
    }

    /// Provide a mock HTTP method.
    var method: Network.HTTPMethod {
        .get
    }

    /// Provide mock headers if needed.
    var headers: [String: String]? {
        [
            "MockHeader1": "Value1",
            "MockHeader2": "Value2"
        ]
    }

    /// Provide mock parameters if needed.
    var parameters: [String: Any]? {
        [
            "param1": "value1",
            "param2": "value2"
        ]
    }
}

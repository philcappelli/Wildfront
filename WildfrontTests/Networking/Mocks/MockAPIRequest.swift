import Foundation

@testable import Wildfront

/// A mock API request conforming to the `APIRequest` protocol and represents a simplified
/// API request with properties such as `path`, `method`, `headers`, and `parameters`.
///
struct MockAPIRequest: APIRequest {
    // MARK: - Properties

    /// The base URL for the API request.
    var baseURL: URL {
        URL(string: "https://example.com")!
    }

    /// The HTTP headers to be included in the API request.
    var headers: [String: String]?

    /// The HTTP method for the API request, such as GET, POST, PUT, or DELETE.
    var method: Network.HTTPMethod

    /// The parameters to be included in the API request, typically for GET or POST requests.
    var parameters: [String: String]?

    /// The path for the API request, which specifies the endpoint.
    var path: String

    /// The URL constructed using the `baseURL`, `path`, and optional `parameters`.
    var url: URL? {
        var components = URLComponents(
            url: baseURL.appendingPathComponent(path),
            resolvingAgainstBaseURL: true
        )

        components?.queryItems = parameters?.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }

        return components?.url
    }

    // MARK: - Initialization

    /// Initializes a `MockAPIRequest` with the specified parameters.
    ///
    /// - Parameters:
    ///   - path: The path for the API request.
    ///   - method: The HTTP method for the request (default is GET).
    ///   - headers: Optional HTTP headers for the request.
    ///   - parameters: Optional parameters to be included in the request.
    ///
    init(
        path: String,
        method: Network.HTTPMethod = .get,
        headers: [String: String]? = nil,
        parameters: [String: String]? = nil
    ) {
        self.path = path
        self.method = method
        self.headers = headers
        self.parameters = parameters
    }
}

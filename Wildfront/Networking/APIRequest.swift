import Foundation

/// Defines the structure of an API request.
///
protocol APIRequest {
    /// The base URL of the API.
    var baseURL: URL { get }

    /// The path for the specific API endpoint.
    var path: String { get }

    /// The HTTP method to be used for the request (e.g., GET, POST, PUT).
    var method: Network.HTTPMethod { get }

    /// Optional HTTP headers to include in the request.
    var headers: [String: String]? { get }

    /// Optional parameters to include in the request.
    var parameters: [String: String]? { get }

    /// The full URL for the API request, including baseURL and path.
    var url: URL? { get }
}

/// Default implementation of the APIRequest protocol.
///
extension APIRequest {
    /// Default implementation for headers, returns nil.
    var headers: [String: String]? { nil }

    /// Default implementation for parameters, returns nil.
    var parameters: [String: Any]? { nil }
}

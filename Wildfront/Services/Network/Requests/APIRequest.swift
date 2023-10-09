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
    var parameters: [String: Any]? { get }
}

/// Default implementation of the APIRequest protocol.
///
class DefaultAPIRequest: APIRequest {
    /// The base URL of the API. Defaults to the value provided in Environment.
    var baseURL: URL {
        guard let baseUrl = Configuration.baseURL else {
            fatalError("Base URL is not provided. You must set it in Environment.")
        }

        return baseUrl
    }

    /// Optional HTTP headers to include in the request. Defaults to an API key header if available.
    var headers: [String: String]? {
        [ Network.HTTPHeaderField.apiKey.rawValue: Configuration.apiToken ]
    }

    /// The HTTP method to be used for the request. Defaults to GET.
    var method: Network.HTTPMethod { .get }

    /// Optional parameters to include in the request. Defaults to nil.
    var parameters: [String: Any]? { nil }

    /// The path for the specific API endpoint. Subclasses must provide a path.
    var path: String {
        fatalError("Path must be implemented by sub class")
    }
}

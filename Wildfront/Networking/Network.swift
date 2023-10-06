import Foundation

/// Struct that contains common networking-related constants and enums.
///
struct Network {
    /// The base URL for API requests.
    static var baseUrl = "developer.nps.gov/api/v1"

    /// Enum defining common HTTP header fields.
    ///
    enum HTTPHeaderField: String {
        /// The "Accept-Encoding" header field used for specifying content encoding preferences.
        case acceptEncoding = "Accept-Encoding"

        /// The "Accept" header field used for specifying the expected media types.
        case acceptType = "Accept"

        /// The "Authorization" header field used for including authentication credentials.
        case authorization = "Authorization"

        /// The "Content-Type" header field used for specifying the media type of the request or response.
        case contentType = "Content-Type"

        /// The "Platform" header field used for specifying the platform or client type.
        case platform = "Platform"

        /// The "Version" header field used for specifying the version of the API.
        case version = "Version"
    }

    /// Enum defining common HTTP request methods.
    ///
    enum HTTPMethod: String {
        /// The HTTP "DELETE" request method.
        case delete = "DELETE"

        /// The HTTP "GET" request method.
        case get = "GET"

        /// The HTTP "POST" request method.
        case post = "POST"

        /// The HTTP "PUT" request method.
        case put = "PUT"
    }
}

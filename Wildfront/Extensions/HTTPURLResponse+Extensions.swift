import Foundation

public extension HTTPURLResponse {
    /// Enum representing HTTP status codes.
    ///
    enum HTTPStatusCode: Int {
        /// Status code for a successful response.
        case success = 200

        /// Status code for a redirection response.
        case redirection = 300

        /// Status code for a client error response.
        case clientError = 400

        /// Status code for a server error response.
        case serverError = 500
    }

    /// Checks if the HTTP response has the specified status code.
    ///
    /// - Parameter code: The HTTP status code to check against.
    /// - Returns: `true` if the response has the specified status code, `false` otherwise.
    func hasStatusCode(_ code: HTTPStatusCode) -> Bool {
        code.rawValue / 100 == statusCode / 100
    }
}

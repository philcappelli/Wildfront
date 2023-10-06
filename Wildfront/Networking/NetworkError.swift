import Foundation

/// Enum representing possible network-related errors.
///
enum NetworkError: Error {
    /// An error indicating that the URL used for the request is invalid.
    case badURL

    /// An error indicating that the response received from the server is invalid.
    case invalidResponse

    /// An error indicating that the request itself failed and passes along the associated error.
    case requestFailed(Error)
}

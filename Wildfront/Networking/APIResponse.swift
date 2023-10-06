import Foundation

/// A protocol that represents the structure of an API response.
///
/// Types conforming to `APIResponse` must be `Decodable`, allowing them to be
/// deserialized from JSON data received from an API.
protocol APIResponse: Decodable {}

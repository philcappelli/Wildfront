import Foundation

/// A struct representing an image associated with a National Park, conforming to Codable and Equatable protocols.
///
struct ParkImage: Codable, Equatable {
    /// The URL of the image.
    let url: URL?
}

import Foundation

/// A struct representing a National Park.
///
struct NationalPark: Codable, Equatable, Identifiable, Hashable {
    /// A unique identifier for the National Park.
    let id: String

    /// A description of the National Park.
    let description: String

    /// The full name of the National Park.
    let fullName: String

    /// An array of images associated with the National Park.
    let images: [ParkImage]

    /// The latitude coordinate of the National Park's location.
    let latitude: String

    /// The longitude coordinate of the National Park's location.
    let longitude: String

    /// The park code for the National Park.
    let parkCode: String

    /// Hashes the National Park using its `id` property for hash-based collections.
    /// - Parameter hasher: The inout Hasher used to combine the hash value.
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

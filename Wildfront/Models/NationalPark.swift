import Foundation

struct NationalPark: Codable, Equatable, Identifiable, Hashable {
    let id: String
    let description: String
    let fullName: String
    let images: [ParkImage]
    let latitude: String
    let longitude: String
    let parkCode: String

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - Image

struct ParkImage: Codable, Equatable {
    let url: URL?
}

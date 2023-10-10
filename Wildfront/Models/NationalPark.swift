import Foundation

struct NationalPark: Codable, Equatable, Identifiable, Hashable {
    var id = UUID()
    let description: String
    let fullName: String
    let images: [Image]
    let latLong: String
    let parkCode: String

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - Image
struct Image: Codable, Equatable {
    let altText: String
    let title: String
    let caption: String
    let url: URL?
    let credit: String
}

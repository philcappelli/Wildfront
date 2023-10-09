import Foundation

struct NationalPark: Codable, Equatable, Identifiable {
    var id = UUID()
    let fullName: String
}

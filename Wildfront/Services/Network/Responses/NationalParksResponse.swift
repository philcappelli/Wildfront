import Foundation

struct NationalParksResponse: APIResponse {
    let start: String
    let data: [NationalPark]
}

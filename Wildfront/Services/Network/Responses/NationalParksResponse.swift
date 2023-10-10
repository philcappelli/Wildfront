import Foundation

/// A struct representing the response received when fetching a list of national parks.
///
struct NationalParksResponse: APIResponse {
    /// An array of `NationalPark` objects containing information about national parks.
    let data: [NationalPark]
}

import Foundation

/// Represents the state of the National Parks feature in the application.
///
struct NationalParksState {
    /// An optional error that can occur during data fetching or processing.
    var error: NationalParksError?

    /// An array of `NationalPark` objects representing the national parks data.
    var parks: [NationalPark] = []

    /// A boolean flag indicating whether data is currently being loaded.
    var isLoading = false
}

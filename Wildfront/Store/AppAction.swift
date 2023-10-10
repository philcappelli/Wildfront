import Foundation

/// An enum representing actions that can be performed within the app.
///
enum AppAction: Equatable {
    /// Actions related to fetching national parks.
    case nationalParks(NationalParksAction)
}

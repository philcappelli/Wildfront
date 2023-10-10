import Combine
import Foundation

/// An enumeration representing possible errors that can occur during National Parks data operations.
///
enum NationalParksError: Error, Equatable {
    /// An error indicating a network-related issue.
    case networkError

    /// An error indicating an issue with parsing data.
    case parsingError
}

/// An enumeration representing actions related to National Parks data.
///
enum NationalParksAction: Equatable {
    /// An action to initiate fetching National Parks data.
    case fetchNationalParks

    /// An action to handle the result of National Parks data fetching.
    case fetchNationalParksResult(Result<[NationalPark], NationalParksError>)
}

extension NationalParksAction {
    /// A computed property that returns an appropriate APIRequest based on the action.
    var request: APIRequest {
        switch self {
            /// Request to fetch National Parks data.
            case .fetchNationalParks:
                NationalParksRequest()

            /// A no-op request for handling action results.
            case .fetchNationalParksResult:
                NoOpAPIRequest()
        }
    }
}

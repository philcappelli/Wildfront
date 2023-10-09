import Combine
import Foundation

enum NationalParksError: Error, Equatable {
    case networkError
    case parsingError
}

enum NationalParksAction: Equatable {
    case fetchNationalParks
    case fetchNationalParksResult(Result<NationalParksResponse, NationalParksError>)
}

extension NationalParksAction {
    var request: APIRequest {
        switch self {
        case .fetchNationalParks:
            NationalParksRequest()
        case .fetchNationalParksResult:
            NoOpAPIRequest()
        }
    }
}

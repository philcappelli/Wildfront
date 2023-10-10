import Foundation

/// A custom API request for fetching national parks data.
///
class NationalParksRequest: DefaultAPIRequest {
    override var path: String {
        Constants.parks
    }

    override var parameters: [String : Any]? {
        [ 
            Constants.limit: 63,
            Constants.parkCode: ParkCodes.nationalParks
                .joined(separator: ",")
        ]
    }
}

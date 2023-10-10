import Foundation

/// A custom API request for fetching national parks data.
///
class NationalParksRequest: DefaultAPIRequest {
    override var path: String {
        "parks"
    }

    override var parameters: [String : Any]? {
        [ 
            "limit": 63,
            "parkCode": ParkCodes.nationalParks
                .joined(separator: ",")
        ]
    }
}

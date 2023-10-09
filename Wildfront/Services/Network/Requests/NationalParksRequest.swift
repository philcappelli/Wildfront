import Foundation

/// A custom API request for fetching national parks data.
///
class NationalParksRequest: DefaultAPIRequest {
    override var path: String {
        "parks"
    }

    override var parameters: [String : Any]? {
        [ 
            "q": "national",
            "parkCode": "zion"
        ]
    }
}

//acad,arch,badl,

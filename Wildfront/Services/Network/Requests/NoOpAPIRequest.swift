import Foundation

/// A dummy API request that should not be used for actual network requests. It conforms to the `APIRequest` protocol.
///
struct NoOpAPIRequest: APIRequest {
    var baseURL: URL { fatalError("NoOpAPIRequest should not be used for actual requests") }
    var path: String { fatalError("NoOpAPIRequest should not be used for actual requests") }
    var method: Network.HTTPMethod { fatalError("NoOpAPIRequest should not be used for actual requests") }
    var headers: [String: String]? { fatalError("NoOpAPIRequest should not be used for actual requests") }
    var parameters: [String: Any]? { fatalError("NoOpAPIRequest should not be used for actual requests") }
}

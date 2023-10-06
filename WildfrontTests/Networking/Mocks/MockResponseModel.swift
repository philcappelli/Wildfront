import Foundation

@testable import Wildfront

/// This struct is used for testing and represents a simplified API response with a single `key` property.
///
struct MockResponseModel: APIResponse {
    /// The value of the `key` property in the response.
    let key: String
}

import Foundation

/// Enum representing environment-specific configuration settings.
///
enum Environment {
    /// Static property for storing the API token used for network requests.
    static var apiToken: String {
        "8YVxqg3hFa92hvwByrW0BkxYHvSnjmMKAmt3CPAh"
    }

    /// Static property for defining the base URL of the API.
    static var baseURL: URL? {
        URL(string: Network.baseUrl)
    }
}

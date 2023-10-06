import Foundation

/// Enum representing environment-specific configuration settings.
///
enum Environment {
    /// Static property for storing the API token used for network requests.
    static var apiToken: String {
        return "" // add API token here
    }

    /// Static property for defining the base URL of the API.
    static var baseURL: URL? {
        return URL(string: Network.baseUrl)
    }
}

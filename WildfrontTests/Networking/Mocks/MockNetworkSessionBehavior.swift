import Foundation

/// Defines various behaviors that a mock network session can simulate when handling network requests.
///
enum MockNetworkSessionBehavior {
    /// Simulates a scenario where the URL used for the request is invalid.
    case badUrl

    /// Simulates a scenario where the network request encounters a failure.
    case failure

    /// Simulates a scenario where the network request succeeds.
    case success

    /// Simulates a scenario where the network request times out.
    case timeout
}

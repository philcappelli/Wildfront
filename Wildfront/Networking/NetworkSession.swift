import Foundation
import Combine

/// Protocol defining the structure of a network session.
///
protocol NetworkSession {
    /// Creates a data task publisher for the given URL request.
    ///
    /// - Parameter request: The URL request for which to create a data task publisher.
    /// - Returns: A data task publisher that emits data and response or an error.
    func dataTaskPublisher(for request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), Error>
}

/// Default implementation of the NetworkSession protocol using URLSession.
///
struct DefaultNetworkSession: NetworkSession {
    /// Creates a data task publisher for the given URL request using URLSession.shared.
    ///
    /// - Parameter request: The URL request for which to create a data task publisher.
    /// - Returns: A data task publisher that emits data and response or an error.
    func dataTaskPublisher(for request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), Error> {
        // Use URLSession.shared to create a data task publisher.
        return URLSession.shared.dataTaskPublisher(for: request)
            // Map URLSession errors to the generic Error type.
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}

import Combine
import Foundation

@testable import Wildfront

/// Struct representing a mock network session that conforms to the NetworkSession protocol.
///
struct MockNetworkSession {
    // MARK: - Properties

    /// The behavior of the mock network session, which determines how it responds to requests.
    let behavior: MockNetworkSessionBehavior

    // MARK: - Initialization

    /// Initialize the mock network session with the specified behavior.
    ///
    init(behavior: MockNetworkSessionBehavior) {
        self.behavior = behavior
    }
}

// MARK: - NetworkSession Implementation

extension MockNetworkSession: NetworkSession {
    func dataTaskPublisher(for request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), Error> {
        switch behavior {
            case .badUrl:
                // Simulate a bad URL error.
                let error = NSError(
                    domain: NSURLErrorDomain,
                    code: NSURLErrorBadURL,
                    userInfo: nil
                )
                return Fail(error: error)
                    .eraseToAnyPublisher()

            case .success:
                // Simulate a successful response with JSON data.
                let jsonString = """
                {
                    "key": "value"
                }
                """

                guard
                    let jsonData = jsonString.data(using: .utf8),
                    let mockResponse = HTTPURLResponse(
                        url: request.url!,
                        statusCode: 200,
                        httpVersion: nil,
                        headerFields: nil
                    )
                else {
                    // Simulate an unknown error when creating the response.
                    return Fail(
                        error: NSError(
                            domain: NSURLErrorDomain,
                            code: NSURLErrorUnknown,
                            userInfo: nil
                        )
                    )
                    .eraseToAnyPublisher()
                }

                return Just((jsonData, mockResponse))
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()

            case .failure:
                // Simulate a failure response.
                return Fail(
                    error: NSError(
                        domain: NSURLErrorDomain,
                        code: NSURLErrorUnknown,
                        userInfo: nil
                    )
                )
                .eraseToAnyPublisher()

            case .timeout:
                // Simulate a timeout response after a delay.
                return Just(())
                    .delay(for: .seconds(5), scheduler: RunLoop.main)
                    .flatMap { _ in
                        Fail(
                            error: NSError(
                                domain: NSURLErrorDomain,
                                code: NSURLErrorTimedOut,
                                userInfo: nil
                            )
                        )
                    }
                    .eraseToAnyPublisher()
        }
    }
}


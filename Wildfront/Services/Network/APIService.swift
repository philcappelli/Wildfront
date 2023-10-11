import Combine
import Foundation

/// Protocol defining the structure of an API service.
///
protocol APIService {
    /// Executes an API request and returns a publisher for the response.
    ///
    /// - Parameter request: The API request to be executed.
    /// - Returns: A publisher emitting a decoded response or an error.
    func make<T: Decodable>(_ request: APIRequest) -> AnyPublisher<T, Error>
}

/// Default implementation of the APIService protocol.
///
final class DefaultAPIService {
    // MARK: - Properties

    /// The network session responsible for making network requests.
    private let session: NetworkSession

    // MARK: - Initialization

    /// Initializes a DefaultAPIService instance with an optional network session.
    ///
    /// - Parameter session: An optional network session (default is DefaultNetworkSession).
    init(session: NetworkSession = DefaultNetworkSession()) {
        self.session = session
    }
}

// MARK: - APIService Implementation

extension DefaultAPIService: APIService {
    func make<T: Decodable>(_ request: APIRequest) -> AnyPublisher<T, Error> {
        var components = URLComponents(url: request.baseURL.appendingPathComponent(request.path), resolvingAgainstBaseURL: false)

        // Check if there are parameters to add
        if let parameters = request.parameters {
            components?.queryItems = parameters.map { key, value in
                URLQueryItem(name: key, value: "\(value)")
            }
        }

        guard let url = components?.url else {
            return Fail<T, Error>(error: NetworkError.invalidUrl).eraseToAnyPublisher()
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue

        request.headers?.forEach {
            urlRequest.addValue($0.value, forHTTPHeaderField: $0.key)
        }

        return session.dataTaskPublisher(for: urlRequest)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap { data, response -> Data in
                guard
                    let httpResponse = response as? HTTPURLResponse,
                    httpResponse.hasStatusCode(.success)
                else { throw NetworkError.invalidResponse }

                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { NetworkError.requestFailed($0) }
            .eraseToAnyPublisher()
    }
}

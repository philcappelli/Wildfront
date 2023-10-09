import Combine
import Foundation

/// Protocol defining the structure of a National Parks repository.
///
protocol NationalParksRepository {
    /// Fetches a list of national parks.
    ///
    /// - Returns: A publisher that emits an array of national park names or an error.
    func fetchNationalParks() -> AnyPublisher<[NationalPark], Error>
}

/// Default implementation of the NationalParksRepository protocol.
///
class DefaultNationalParksRepository: NationalParksRepository {
    /// An instance of an APIService used to make API requests.
    private let apiService: APIService

    /// Initializes a DefaultNationalParksRepository with an APIService.
    ///
    /// - Parameter apiService: An APIService for making API requests.
    init(apiService: APIService) {
        self.apiService = apiService
    }

    /// Fetches a list of national parks.
    ///
    /// - Returns: A publisher that emits an array of national park names or an error.
    func fetchNationalParks() -> AnyPublisher<[NationalPark], Error> {
        apiService.make(NationalParksRequest())
    }
}

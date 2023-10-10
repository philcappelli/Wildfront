import Combine
import Foundation

@testable import Wildfront

/// A Mock repository used for testing.
class MockNationalParksRepository: NationalParksRepository {
    private let isSuccess: Bool

    init(isSuccess: Bool = true) {
        self.isSuccess = isSuccess
    }

    func fetchNationalParks() -> AnyPublisher<NationalParksResponse, Error> {
        if isSuccess {
            let response = NationalParksResponse(
                data: NationalPark.fixtures()
            )

            return Result.Publisher(response)
                .eraseToAnyPublisher()
        } else {
            let error = NSError(
                domain: "MockNationalParksRepository",
                code: 0,
                userInfo: [ NSLocalizedDescriptionKey: "Failed to fetch national parks" ]
            )

            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }
}

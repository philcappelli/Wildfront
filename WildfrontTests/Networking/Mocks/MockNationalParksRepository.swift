import Combine
import Foundation

@testable import Wildfront

class MockNationalParksRepository: NationalParksRepository {
    private let isSuccess: Bool

    init(isSuccess: Bool = true) {
        self.isSuccess = isSuccess
    }

    func fetchNationalParks() -> AnyPublisher<NationalParksResponse, Error> {
        if isSuccess {
            let mockNationalParks = [
                NationalPark(fullName: "Yellowstone National Park"),
                NationalPark(fullName: "Yosemite National Park"),
                NationalPark(fullName: "Grand Canyon National Park")
            ]

            let response = NationalParksResponse(
                start: "0",
                data: mockNationalParks
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

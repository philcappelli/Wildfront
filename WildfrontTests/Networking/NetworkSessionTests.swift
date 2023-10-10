import XCTest
import Combine

@testable import Wildfront

class NetworkSessionTests: XCTestCase {
    func testDefaultNetworkSession() {
        let networkSession: NetworkSession = DefaultNetworkSession()

        let url = URL(string: "https://example.com")!
        let request = URLRequest(url: url)

        let expectation = XCTestExpectation(description: "Network request")

        let cancellable = networkSession.dataTaskPublisher(for: request)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break // Test succeeded
                case .failure(let error):
                    XCTFail("Network request failed with error: \(error)")
                }
                expectation.fulfill()
            }, receiveValue: { data, response in })

        wait(for: [expectation], timeout: 5.0)
        cancellable.cancel()
    }
}

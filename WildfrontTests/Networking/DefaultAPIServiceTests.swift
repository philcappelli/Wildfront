import XCTest
import Combine

@testable import Wildfront

/// Unit tests for the `DefaultAPIService` class. This test suite focuses on ensuring the functionality
/// and behavior of the `DefaultAPIService` when making API requests, handling successful
/// responses, error cases, timeouts, and concurrent requests.
///
class DefaultAPIServiceTests: XCTestCase {
    // MARK: - Properties

    /// Set to store cancellables for cleanup after each test
    private var cancellables: Set<AnyCancellable> = []

    /// Shared mock API request
    private let mockRequest = MockAPIRequest()

    // MARK: - Lifecycle

    override func tearDown() {
        super.tearDown()

        // Cancel all active cancellables to avoid resource leaks
        cancellables.forEach {
            $0.cancel()
        }
    }

    /// Test a successful API request
    func testSuccessfulRequest() {
        // Create a DefaultAPIService instance with a MockNetworkSession that simulates a successful request
        let apiService = DefaultAPIService(session: MockNetworkSession(behavior: .success))

        // Create an expectation for the API request
        let expectation = expectation(description: "API Request Expectation")

        // Define a variable to capture the result of a successful API request.
        var receivedResult: MockResponseModel?

        // Call the API service's make method and handle the result
        let cancellable = apiService.make(mockRequest)
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .finished:
                        // The request succeeded
                        break
                    case .failure(let error):
                        // The request failed
                        XCTFail("API request failed with error: \(error)")
                }
                expectation.fulfill()
            }, receiveValue: { value in
                // Receive and store the result
                receivedResult = value
            })

        // Store the cancellable in the global set to avoid it being deallocated prematurely
        cancellable.store(in: &cancellables)

        // Wait for the expectation to be fulfilled (maximum 5 seconds)
        waitForExpectations(timeout: 5, handler: nil)

        // Assert the result
        XCTAssertNotNil(receivedResult)
        XCTAssertEqual(receivedResult?.key, "value")
    }

    /// Test a failed API request
    func testFailedRequest() {
        // Create a DefaultAPIService instance with a MockNetworkSession that simulates a failed request
        let apiService = DefaultAPIService(session: MockNetworkSession(behavior: .failure))

        // Create an expectation for the API request
        let expectation = expectation(description: "API Request Expectation")

        var receivedError: Error?

        // Call the API service's make method and handle the result
        let cancellable = apiService.make(mockRequest)
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .finished:
                        // The request should fail, but it succeeded
                        XCTFail("API request should fail but it succeeded")
                    case .failure(let error):
                        // Receive and store the error
                        receivedError = error
                }
                expectation.fulfill()
            }, receiveValue: { (_: MockResponseModel) in
                // This block should not be executed for a failed request
                XCTFail("Receive value should not be called for a failed request")
            })

        // Store the cancellable in the global set to avoid it being deallocated prematurely
        cancellable.store(in: &cancellables)

        // Wait for the expectation to be fulfilled (maximum 5 seconds)
        waitForExpectations(timeout: 5, handler: nil)

        // Assert the received error
        XCTAssertNotNil(receivedError)
    }

    /// Test a timeout during the API request
    func testTimeoutRequest() {
        // Create a DefaultAPIService instance with a MockNetworkSession that simulates a timeout
        let apiService = DefaultAPIService(session: MockNetworkSession(behavior: .timeout))

        // Create an expectation for the API request
        let expectation = expectation(description: "API Request Expectation")

        var receivedError: Error?

        // Call the API service's make method and handle the result
        let cancellable = apiService.make(mockRequest)
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .finished:
                        // The request should time out, but it succeeded
                        XCTFail("API request should time out but it succeeded")
                    case .failure(let error):
                        // Receive and store the error
                        receivedError = error
                }
                expectation.fulfill()
            }, receiveValue: { (_: MockResponseModel) in
                // This block should not be executed for a timed-out request
                XCTFail("Receive value should not be called for a timed-out request")
            })

        // Store the cancellable in the global set to avoid it being deallocated prematurely
        cancellable.store(in: &cancellables)

        // Wait for the expectation to be fulfilled (maximum 10 seconds)
        waitForExpectations(timeout: 10, handler: nil)

        // Assert the received error
        XCTAssertNotNil(receivedError)
    }

    /// Test concurrent API requests
    func testConcurrentRequests() {
        // Create two mock API requests
        let mockRequest1 = MockAPIRequest()
        let mockRequest2 = MockAPIRequest()

        // Create a DefaultAPIService instance with the MockNetworkSession
        let apiService = DefaultAPIService(session: MockNetworkSession(behavior: .success))

        // Create expectations for both requests
        let expectation1 = expectation(description: "API Request 1 Expectation")
        let expectation2 = expectation(description: "API Request 2 Expectation")

        var receivedResult1: MockResponseModel?
        var receivedResult2: MockResponseModel?

        // Call the API service's make method for both requests concurrently
        let cancellable1 = apiService.make(mockRequest1)
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        XCTFail("API request 1 failed with error: \(error)")
                }
                expectation1.fulfill()
            }, receiveValue: { value in
                receivedResult1 = value
            })

        let cancellable2 = apiService.make(mockRequest2)
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        XCTFail("API request 2 failed with error: \(error)")
                }
                expectation2.fulfill()
            }, receiveValue: { value in
                receivedResult2 = value
            })

        // Store the cancellables in the global set to avoid them being deallocated prematurely
        cancellable1.store(in: &cancellables)
        cancellable2.store(in: &cancellables)

        // Wait for both expectations to be fulfilled (maximum 5 seconds)
        waitForExpectations(timeout: 5, handler: nil)

        // Assert the results of both requests
        XCTAssertNotNil(receivedResult1)
        XCTAssertNotNil(receivedResult2)
    }

    /// Test a network request with a bad URL
    func testNetworkRequestWithBadURL() {
        // Create a mock API request with a bad URL
        let mockRequest = MockAPIRequest()

        // Create a DefaultAPIService instance with a MockNetworkSession that simulates a bad URL request
        let apiService = DefaultAPIService(session: MockNetworkSession(behavior: .invalidUrl))

        // Create an expectation for the API request
        let expectation = expectation(description: "API Request Expectation")

        var receivedError: Error?

        // Call the API service's make method and handle the result
        let cancellable = apiService.make(mockRequest)
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .finished:
                        // The request should fail due to a bad URL
                        XCTFail("API request should fail due to a bad URL")
                    case .failure(let error):
                        // Receive and store the error
                        receivedError = error
                }
                expectation.fulfill()
            }, receiveValue: { (_: MockResponseModel) in
                // This block should not be executed for a failed request
                XCTFail("Receive value should not be called for a failed request")
            })

        // Store the cancellable in the global set to avoid it being deallocated prematurely
        cancellable.store(in: &cancellables)

        // Wait for the expectation to be fulfilled (maximum 5 seconds)
        waitForExpectations(timeout: 5, handler: nil)

        // Assert the received error
        XCTAssertNotNil(receivedError)
    }
}

import Combine
import XCTest

@testable import Wildfront

class MiddlewareTests: XCTestCase {
    var cancellables: Set<AnyCancellable> = []
    var store: Store<AppState, AppAction>!

    override func setUp() {
        super.setUp()
        store = Store(
            initialState: AppState(),
            middleware: [networkingMiddleware(repository: MockNationalParksRepository())],
            reducer: appReducer
        )
    }

    override func tearDown() {
        store = nil
        cancellables.removeAll()
        super.tearDown()
    }

    /// Test case to verify the behavior when national parks are fetched successfully.
    func testFetchNationalParksSuccess() {
        let action = AppAction.nationalParks(.fetchNationalParks)
        let expectation = XCTestExpectation(description: "National Parks fetched successfully")
        store.dispatch(action)

        // Observe changes in the state and assert expected outcomes
        withObservationTracking({
            XCTAssertEqual(store.state.nationalParksState.isLoading, false)
            XCTAssertNotNil(store.state.nationalParksState.parks)
            XCTAssertNil(store.state.nationalParksState.error)
            expectation.fulfill()
        }, onChange: {}
        )

        wait(for: [expectation], timeout: 5.0)
    }

    /// Test case to verify the behavior when the fetch national parks result is a failure.
    func testFetchNationalParksFailure() {
        let action = AppAction.nationalParks(.fetchNationalParks)
        let expectation = XCTestExpectation(description: "National Parks fetch failed")
        store = Store(
            initialState: AppState(),
            middleware: [
                networkingMiddleware(
                    repository: MockNationalParksRepository(isSuccess: false)
                )
            ],
            reducer: appReducer
        )

        store.dispatch(action)

        // Observe changes in the state and assert expected outcomes
        withObservationTracking({
            XCTAssertEqual(store.state.nationalParksState.isLoading, false)
            XCTAssertEqual(store.state.nationalParksState.parks.count, 0)
            XCTAssertNotNil(store.state.nationalParksState.error)
            expectation.fulfill()
        }, onChange: {}
        )

        wait(for: [expectation], timeout: 5.0)
    }
}

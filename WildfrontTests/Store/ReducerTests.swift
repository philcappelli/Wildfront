import XCTest

@testable import Wildfront

/// Testing the reducer.
class ReducerTests: XCTestCase {
    // Test case to verify the behavior when fetching national parks is initiated.
    func testNationalParksReducerFetch() {
        var state = NationalParksState()
        nationalParksReducer(state: &state, action: .fetchNationalParks)
        XCTAssertTrue(state.isLoading)
        XCTAssertNil(state.error)
    }

    // Test case to verify the behavior when the fetch national parks result is successful.
    func testNationalParksReducerResultSuccess() {
        var state = NationalParksState()
        nationalParksReducer(
            state: &state,
            action: .fetchNationalParksResult(
                .success(NationalPark.fixtures())
            )
        )
        XCTAssertEqual(state.parks.count, 3)
        XCTAssertNil(state.error)
    }

    // Test case to verify the behavior when the fetch national parks result is a failure.
    func testNationalParksReducerResultFailure() {
        var state = NationalParksState()
        nationalParksReducer(state: &state, action: .fetchNationalParksResult(.failure(.networkError)))
        XCTAssertEqual(state.parks.count, 0)
        XCTAssertEqual(state.error, .networkError)
    }

    // Test case to verify the behavior of the app reducer.
    func testAppReducer() {
        var appState = AppState()
        appReducer(
            state: &appState,
            action: .nationalParks(
                .fetchNationalParksResult(
                    .success(NationalPark.fixtures())
                )
            )
        )
        XCTAssertEqual(appState.nationalParksState.parks.count, 3)
        XCTAssertNil(appState.nationalParksState.error)
    }
}

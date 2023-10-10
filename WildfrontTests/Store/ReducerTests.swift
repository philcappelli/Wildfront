import XCTest

@testable import Wildfront

class ReducerTests: XCTestCase {
    func testNationalParksReducerFetch() {
        var state = NationalParksState()
        nationalParksReducer(state: &state, action: .fetchNationalParks)
        XCTAssertTrue(state.isLoading)
        XCTAssertNil(state.error)
    }

    func testNationalParksReducerResultSuccess() {
        var state = NationalParksState()
        nationalParksReducer(
            state: &state,
            action: .fetchNationalParksResult(
                .success([
                    NationalPark(fullName: "Park A"),
                    NationalPark(fullName: "Park B")
                ])
            )
        )
        XCTAssertEqual(state.parks.count, 2)
        XCTAssertNil(state.error)
    }

    func testNationalParksReducerResultFailure() {
        var state = NationalParksState()
        nationalParksReducer(state: &state, action: .fetchNationalParksResult(.failure(.networkError)))
        XCTAssertEqual(state.parks.count, 0)
        XCTAssertEqual(state.error, .networkError)
    }

    func testAppReducer() {
        var appState = AppState()
        appReducer(
            state: &appState,
            action: .nationalParks(
                .fetchNationalParksResult(
                    .success([
                        NationalPark(fullName: "Park X"),
                        NationalPark(fullName: "Park Y")
                    ])
                )
            )
        )
        XCTAssertEqual(appState.nationalParksState.parks.count, 2)
        XCTAssertNil(appState.nationalParksState.error)
    }
}

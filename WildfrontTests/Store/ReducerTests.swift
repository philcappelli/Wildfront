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
        nationalParksReducer(state: &state, action: .fetchNationalParksResult(.success([NationalPark(name: "Park A"), NationalPark(name: "Park B")])))
        XCTAssertEqual(state.parks.count, 2)
        XCTAssertNil(state.error)
    }

    func testNationalParksReducerResultFailure() {
        var state = NationalParksState()
        nationalParksReducer(state: &state, action: .fetchNationalParksResult(.failure(.genericError)))
        XCTAssertEqual(state.parks.count, 0)
        XCTAssertEqual(state.error, .genericError)
    }

    func testAppReducer() {
        var appState = AppState()
        appReducer(state: &appState, action: .nationalParks(.fetchNationalParksResult(.success([NationalPark(name: "Park X"), NationalPark(name: "Park Y")]))))
        XCTAssertEqual(appState.nationalParksState.parks.count, 2)
        XCTAssertNil(appState.nationalParksState.error)
    }
}

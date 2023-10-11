import XCTest

@testable import Wildfront

/// Testing the AppReducer is working as expected.
class AppReducerTests: XCTestCase {
    /// Test case to verify the behavior of the app reducer.
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

import SnapshotTesting
import SwiftUI
import ViewInspector
import XCTest

@testable import Wildfront

final class NationalParksViewTests: XCTestCase {
    /// Testing the main view showing the header and search bar.
    func testFetchNationalParks() {
        let mockStore = Store(
            initialState: AppState(
                nationalParksState: NationalParksState(
                    parks: NationalPark.fixtures()
                )
            ),
            reducer: appReducer
        )

        let view = NationalParksView(store: mockStore)
        assertSnapshot(matching: view, as: .image)
    }
}



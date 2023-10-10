import SnapshotTesting
import SwiftUI
import ViewInspector
import XCTest

@testable import Wildfront

final class ParkCardViewTests: XCTestCase {
    /// Testing the park card view is shown with a loading spinner.
    func testFetchNationalParks() {
        let view = ParkCardView(park: NationalPark.fixture())
        assertSnapshot(matching: view, as: .image)
    }
}



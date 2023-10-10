import SnapshotTesting
import SwiftUI
import ViewInspector
import XCTest

@testable import Wildfront

final class NationalParkDetailViewTests: XCTestCase {
    /// Testing the detail screen.  Having issues with the snapshot library due to size so had to specify my own.
    /// Also showing weirdness with the Map in the snapshot testing but wanted to keep this anyway as a test.
    ///
    /// I did find people with the same issue here (https://github.com/pointfreeco/swift-snapshot-testing/issues/738)
    func testFetchNationalParks() {
        let view = NationalParkDetailsView(park: NationalPark.fixture())
            .frame(
                width:  UIScreen.main.bounds.width,
                height:  UIScreen.main.bounds.height
            )
        
        assertSnapshot(matching: view, as: .image())
    }
}



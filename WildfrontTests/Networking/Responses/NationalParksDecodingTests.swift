import XCTest
import Combine

@testable import Wildfront

/// A test case to verify the decoding of NationalPark objects from a test JSON file.
///
class NationalParksDecodingTests: XCTestCase {
    func testDecodingNationalParks() {
        let testBundle = Bundle(for: type(of: self))
        guard let url = testBundle.url(forResource: "NationalParksResponse", withExtension: "json") else {
            XCTFail("Test JSON file not found.")
            return
        }

        let data = try! Data(contentsOf: url)
        let decoder = JSONDecoder()

        do {
            let nationalParksResponse = try decoder.decode(NationalParksResponse.self, from: data)
            let nationalParks = nationalParksResponse.data
            XCTAssertEqual(nationalParks.count, 2) // Adjust the count according to your test JSON data
        } catch {
            XCTFail("Decoding failed with error: \(error)")
        }
    }
}

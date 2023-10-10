//
//  NationalParks+Fixtures.swift
//  Wildfront
//
//  Created by Philip on 10/10/23.
//

import Foundation

extension NationalPark {

    /// Returns a single mock NationalPark objects for testing.
    static func fixture() -> NationalPark {
        NationalPark(
            id: "1",
            description: "Description of Park 1",
            fullName: "National Park 1",
            images: [ ParkImage(url: URL(string: "https://example.com/image1.jpg")) ],
            latitude: "12.3456",
            longitude: "78.9012",
            parkCode: "park1"
        )
    }

    /// Returns an array of mock NationalPark objects for testing.
    static func fixtures() -> [NationalPark] {
        let park1 = NationalPark(
            id: "1",
            description: "Description of Park 1",
            fullName: "National Park 1",
            images: [ ParkImage(url: URL(string: "https://example.com/image1.jpg")) ],
            latitude: "12.3456",
            longitude: "78.9012",
            parkCode: "park1"
        )

        let park2 = NationalPark(
            id: "2",
            description: "Description of Park 2",
            fullName: "National Park 2",
            images: [ParkImage(url: URL(string: "https://example.com/image2.jpg"))],
            latitude: "34.5678",
            longitude: "56.1234",
            parkCode: "park2"
        )

        let park3 = NationalPark(
            id: "3",
            description: "Description of Park 3",
            fullName: "National Park 3",
            images: [ParkImage(url: URL(string: "https://example.com/image3.jpg"))],
            latitude: "56.7890",
            longitude: "12.3456",
            parkCode: "park3"
        )

        // Add more mock NationalPark objects as needed

        return [park1, park2, park3]
    }
}

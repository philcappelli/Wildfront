import MapKit
import SwiftUI

struct ParkDetailsView: View {
    let park: NationalPark

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(park.fullName)
                    .font(.largeTitle)

                Text("Description: \(park.description)")
                    .font(.headline)

                // Display park images if available
                if !park.images.isEmpty {
                    ParkImagesView(images: park.images)
                }

                Text("Location: \(park.latLong)")
                    .font(.headline)
            }
            .padding()
        }
        .navigationBarTitle("Park Details", displayMode: .inline)
    }
}

struct ParkImagesView: View {
    let images: [Image]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Images")
                .font(.headline)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(images, id: \.url) { image in
                        ParkImageView(image: image)
                            .frame(width: 200, height: 150)
                            .cornerRadius(10)
                    }
                }
            }
        }
    }
}

struct ParkImageView: View {
    let image: Image

    var body: some View {
        Group {
            if let imageUrl = image.url {
                AsyncImage(url: imageUrl) { phase in
                    switch phase {
                    case .empty:
                        // Placeholder or loading view
                        ProgressView()
                    case .success(let image):
                        // Loaded image
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    case .failure:
                        // Error view
                        Text("Failed to load image")
                    @unknown default:
                        // Handle future cases
                        EmptyView()
                    }
                }
                .font(.subheadline)
            } else {
                // If the URL is not valid, display a placeholder or error view
                Text("Invalid URL")
                    .font(.subheadline)
            }
        }
    }
}


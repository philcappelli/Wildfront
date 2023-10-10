import MapKit
import NukeUI
import SwiftUI

struct ParkDetailsView: View {
    let park: NationalPark
    @State private var region: MKCoordinateRegion?

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ZStack(alignment: .bottom) {
                    LazyImage(url: park.images.randomElement()?.url) { state in
                        if let image = state.image {
                            image
                                .resizable(resizingMode: .stretch)
                                //.scaledToFill()
                                .clipped()
                                //.frame(height: 500)
                        } else if state.error != nil {
                            Color.gray
                        } else {
                            ProgressView()
                        }
                    }
                    .frame(height: 300)

                    Text(park.fullName)
                        .font(.largeTitle)
                        .frame(width: UIScreen.main.bounds.width - 20)
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                        .padding(.horizontal, 20)
                        .background(.ultraThinMaterial, in:
                            Rectangle()
                        )
                }

                Text(park.description)
                    .font(.body)
                    .frame(width: UIScreen.main.bounds.width - 20)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .padding(.horizontal, 20)

                if let region = region {
                    Map(initialPosition: .region(region)) {
                        Marker(
                            park.fullName,
                            coordinate: CLLocationCoordinate2D(
                                latitude: Double(park.latitude) ?? 0.0,
                                longitude: Double(park.longitude) ?? 0.0)
                        )
                        .tint(.orange)
                    }
                    .frame(height: 400)
                    .cornerRadius(10)
                    .padding(.all, 20)
                }
            }
        }.onAppear {
            region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: Double(park.latitude) ?? 0.0,
                    longitude: Double(park.longitude) ?? 0.0
                ),
                span: MKCoordinateSpan(
                    latitudeDelta: 3.0,
                    longitudeDelta: 3.0
                )
            )
        }
    }
}

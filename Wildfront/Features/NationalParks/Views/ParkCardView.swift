import NukeUI
import SwiftUI

struct ParkCardView: View {
    let park: NationalPark
    let cardHeight: CGFloat = 200

    var body: some View {
        ZStack(alignment: .bottom) {
            LazyImage(url: park.images.first?.url) { state in
                if let image = state.image {
                    image
                        .resizable()
                        .scaledToFill()
                        .cornerRadius(10)
                        .clipped()
                } else if state.error != nil {
                    Color.gray
                } else {
                    ProgressView()
                }
            }
            .frame(width: UIScreen.main.bounds.width - 40, height: cardHeight)

            Text(park.fullName)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: UIScreen.main.bounds.width - 40)
                .background(.ultraThinMaterial, in:
                    Rectangle()
                )
        }
        .frame(height: cardHeight)
        .cornerRadius(10)
    }
}


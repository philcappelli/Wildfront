import Observation
import SwiftUI

struct NationalParksView: View {
    @State private var selectedPark: NationalPark?
    @State var store: Store<AppState, AppAction>

    var body: some View {
        NavigationView {
            Group {
                if store.state.nationalParksState.isLoading {
                    ProgressView("Loading...")
                } else {
                    List {
                        ForEach(store.state.nationalParksState.parks) { park in
                            ParkCardView(park: park)
                                .onTapGesture {
                                    selectedPark = park
                                }
                        }
                    }
                    .sheet(item: $selectedPark) { park in
                        ParkDetailsView(park: park)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("National Parks")
        }
        .task {
            store.dispatch(.nationalParks(.fetchNationalParks))
        }
    }
}

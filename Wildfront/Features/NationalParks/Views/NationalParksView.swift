import Observation
import SwiftUI

struct NationalParksView: View {
    @State private var searchText = ""
    @State private var selectedPark: NationalPark?
    @State var store: Store<AppState, AppAction>

    var body: some View {
        NavigationStack {
            Group {
                if store.state.nationalParksState.isLoading {
                    ProgressView()
                } else {
                    List {
                        ForEach(searchResults) { park in
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
        .searchable(text: $searchText)
    }

    var searchResults: [NationalPark] {
        if searchText.isEmpty {
            return store.state.nationalParksState.parks
        } else {
            return store.state.nationalParksState.parks.filter {
                $0.fullName.contains(searchText)
            }
        }
    }
}

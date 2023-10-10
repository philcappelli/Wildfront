import Observation
import SwiftUI

/// A view that shows the list of the National Parks.
///
struct NationalParksView: View {
    // MAR: - Properties

    /// The search text used to handle searching for a park via the search bar.
    @State private var searchText = ""

    /// The select part a user wants to see details about,
    @State private var selectedPark: NationalPark?

    /// The store which handles the views state and dispatches actions.
    @State var store: Store<AppState, AppAction>

    // MARK: - View
    
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

    /// Returns an array of `NationalPark` objects that match the search criteria.
    ///
    /// - Returns: An array of `NationalPark` objects that contain the `searchText` in their full name.
    /// If `searchText` is empty, all parks are returned.
    var searchResults: [NationalPark] {
        searchText.isEmpty
            ? store.state.nationalParksState.parks
            : store.state.nationalParksState.parks.filter { $0.fullName.contains(searchText) }
    }
}

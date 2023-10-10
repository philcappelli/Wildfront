import Observation
import SwiftUI

/// A view that shows the list of the National Parks.
///
struct NationalParksView: View {
    // MARK: - Properties

    /// The search text used to handle searching for a park via the search bar.
    @State private var searchText = ""

    /// The select part a user wants to see details about,
    @State private var selectedPark: NationalPark?

    /// The store which handles the views state and dispatches actions.
    @State var store: Store<AppState, AppAction>

    /// Indicates whether an alert should be presented.
    @State private var isAlertPresented = false

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
                        NationalParkDetailsView(park: park)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle(Constants.navigationTitle)
        }
        .task {
            store.dispatch(.nationalParks(.fetchNationalParks))
        }
        .alert(Constants.errorAlertTitle, isPresented: $isAlertPresented) {
            Button(Constants.errorAlertButtonText, role: .cancel) {
                isAlertPresented = false
                store.dispatch(.nationalParks(.fetchNationalParks))
            }
        } message: {
            Text(Constants.errorAlertMessage)
        }
        .searchable(text: $searchText)
        .onChange(of: store.state.nationalParksState.error) {
            isAlertPresented = store.state.nationalParksState.error != nil
        }
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

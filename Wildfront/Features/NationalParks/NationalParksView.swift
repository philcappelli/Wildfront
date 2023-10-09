import Observation
import SwiftUI

struct NationalParksView: View {
    @State var store: Store<AppState, AppAction>

    var body: some View {
        VStack {
            Text("National Parks")
                .font(.largeTitle)

            if store.state.nationalParksState.isLoading {
                ProgressView("Loading...")
            } else {
                List {
                    ForEach(store.state.nationalParksState.parks) { park in
                        Text(park.fullName)
                    }
                }
                .task {
                    store.dispatch(.nationalParks(.fetchNationalParks))
                }
            }

            if let error = store.state.nationalParksState.error {
                Text("Error: \(error.localizedDescription)")
            }
        }
    }
}

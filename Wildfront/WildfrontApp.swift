import SwiftUI

/// The main entryway into the app.
///
@main
struct WildfrontApp: App {
    @State private var store = Store(
        initialState: AppState(
            nationalParksState: NationalParksState()
        ),
        middleware: [
            networkingMiddleware(
                repository: DefaultNationalParksRepository(
                    apiService: DefaultAPIService()
                )
            )
        ],
        reducer: appReducer(state:action:)
    )

    var body: some Scene {
        WindowGroup {
            NationalParksView(store: store)
        }
    }
}

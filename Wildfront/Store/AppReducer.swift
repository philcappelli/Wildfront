import Foundation

/// A reducer function that handles app-level state changes based on actions.
///
/// - Parameters:
///   - state: The current app state.
///   - action: The action to be performed.
///
func appReducer(
    state: inout AppState,
    action: AppAction
) {
    switch action {
        /// Delegate the action to the specific reducer for national parks.
        case .nationalParks(let nationalParksAction):
            nationalParksReducer(
                state: &state.nationalParksState,
                action: nationalParksAction
            )
    }
}

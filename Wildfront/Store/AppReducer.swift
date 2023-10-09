import Foundation

func appReducer(
    state: inout AppState,
    action: AppAction
) {
    switch action {
    case .nationalParks(let nationalParksAction):
        nationalParksReducer(
            state: &state.nationalParksState,
            action: nationalParksAction
        )
    }
}

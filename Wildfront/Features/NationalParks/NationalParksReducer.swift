import Foundation

/// A reducer function that processes National Parks-related actions and updates the state accordingly.
///
/// - Parameters:
///   - state: The inout state representing the current National Parks state.
///   - action: The National Parks action to be processed.
///
func nationalParksReducer(
    state: inout NationalParksState,
    action: NationalParksAction
) {
    switch action {
        case .fetchNationalParks:
            state.isLoading = true
            state.error = nil
        case let .fetchNationalParksResult(result):
            state.isLoading = false
            switch result {
                case .success(let nationalParks):
                    state.parks = nationalParks
                    state.error = nil
                case .failure(let error):
                    state.error = error
                    state.parks = []
            }
    }
}

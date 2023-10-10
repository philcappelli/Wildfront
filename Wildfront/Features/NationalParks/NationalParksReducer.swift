import Foundation

func nationalParksReducer(
    state: inout NationalParksState,
    action: NationalParksAction
) {
    switch action {
        case .fetchNationalParks:
            state.isLoading = true
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

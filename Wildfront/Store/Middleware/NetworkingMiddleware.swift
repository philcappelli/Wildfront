import Foundation

/// Middleware for handling networking-related actions, such as fetching national parks data.
///
/// This middleware intercepts specific actions related to networking, performs asynchronous network requests,
/// and dispatches appropriate actions to update the app's state.
///
/// - Parameters:
///   - repository: The repository responsible for fetching national parks data.
/// - Returns: A middleware function that processes actions and handles network requests.
///
func networkingMiddleware(repository: NationalParksRepository) -> Middleware<AppState, AppAction> {
    { state, action, dispatch in
        switch action {
            case .nationalParks(.fetchNationalParks):
                _ = repository.fetchNationalParks()
                    .sink(receiveCompletion: { completion in
                        switch completion {
                            case .finished:
                                break
                            case .failure:
                                dispatch(
                                    .nationalParks(.fetchNationalParksResult(
                                        .failure(.parsingError))
                                    )
                                )
                        }
                    }, receiveValue: {
                        dispatch(
                            .nationalParks(.fetchNationalParksResult(
                                .success($0.data)
                            ))
                        )
                    })
            default:
                dispatch(action)
        }
    }
}

import Foundation

func networkingMiddleware(repository: NationalParksRepository) -> Middleware<AppState, AppAction> {
    return { state, action, dispatch in
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
                                .success($0.data))
                            )
                        )
                    })
            default:
                dispatch(action)
        }
    }
}

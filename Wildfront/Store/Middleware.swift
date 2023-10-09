import Foundation
import Combine

typealias Middleware<State, Action> = (
    _ state: State,
    _ action: Action,
    _ dispatch: @escaping (Action) -> Void
) -> ()

func nationalParksMiddleware(service: APIService) -> Middleware<AppState, AppAction> {
    return { state, action, dispatch in
        switch action {
            case .nationalParks(.fetchNationalParks):
                _ = service.make(NationalParksRequest())
                    .sink(receiveCompletion: { completion in
                        switch completion {
                            case .finished:
                                print("completed")
                                break
                            case .failure(let error):
                                print("ERROR: \(error)")
                                dispatch(.nationalParks(.fetchNationalParksResult(.failure(.parsingError))))
                        }
                    }, receiveValue: { data in
                        dispatch(.nationalParks(.fetchNationalParksResult(.success(data))))
                        dump(data)
                    })
            default:
                dispatch(action)
        }
    }
}

import Combine
import Foundation

@Observable
final class Store<AppState, AppAction> {
    private(set) var state: AppState

    private var cancellables: Set<AnyCancellable> = []
    private var middleware: [ Middleware<AppState, AppAction> ]
    private let reducer: (inout AppState, AppAction) -> Void

    init(
        initialState: AppState,
        middleware: [ Middleware<AppState, AppAction> ] = [],
        reducer: @escaping (inout AppState, AppAction) -> Void
    ) {
        self.state = initialState
        self.middleware = middleware
        self.reducer = reducer
    }

    func dispatch(_ action: AppAction) {
        var next: (AppAction) -> Void = { [weak self] action in
            guard let self else { return }
            self.reducer(&self.state, action)
        }

        for middleware in middleware {
            let previousMiddleware = next
            next = { [weak self] in
                guard let self else { return }
                middleware(self.state, $0, previousMiddleware)
            }
        }

        next(action)
    }
}

import Combine
import Foundation

/// A store that manages the state and actions of the app.
///
@Observable
final class Store<AppState, AppAction> {
    // MARK: - Properties

    /// The current state of the app.
    private(set) var state: AppState

    /// A set of cancellables to manage Combine subscriptions.
    private var cancellables: Set<AnyCancellable> = []

    /// Middleware functions to handle actions before they reach the reducer.
    private var middleware: [Middleware<AppState, AppAction>]

    /// The reducer function that updates the app's state based on actions.
    private let reducer: (inout AppState, AppAction) -> Void

    // MARK: - Initialization

    /// Initializes a new store with the provided initial state, middleware, and reducer.
    ///
    /// - Parameters:
    ///   - initialState: The initial state of the app.
    ///   - middleware: Middleware functions to handle actions.
    ///   - reducer: The reducer function to update the state based on actions.
    ///
    init(
        initialState: AppState,
        middleware: [Middleware<AppState, AppAction>] = [],
        reducer: @escaping (inout AppState, AppAction) -> Void
    ) {
        self.state = initialState
        self.middleware = middleware
        self.reducer = reducer
    }

    // MARK: - Dispatch Actions

    /// Dispatches an action to update the app's state.
    /// - Parameter action: The action to be dispatched.
    ///
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

        // Update the state first (before middleware)
        reducer(&self.state, action)

        // This call triggers the middleware chain
        next(action)
    }
}

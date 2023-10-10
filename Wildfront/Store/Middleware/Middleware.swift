import Foundation
import Combine

/// Middleware is a typealias for functions that intercept and process actions before they reach the reducer.
///
/// Middleware functions take the current state, an incoming action, and a dispatch function as parameters.
/// They can process the action, perform side effects, or conditionally dispatch new actions.
///
/// - Parameters:
///   - state: The current state of the app.
///   - action: The incoming action to be processed.
///   - dispatch: A function to dispatch new actions.
///
/// Middleware functions are used to implement features like logging, asynchronous operations, or handling specific actions.
///
typealias Middleware<State, Action> = (
    _ state: State,
    _ action: Action,
    _ dispatch: @escaping (Action) -> Void
) -> ()

import Foundation
import Combine

typealias Middleware<State, Action> = (
    _ state: State,
    _ action: Action,
    _ dispatch: @escaping (Action) -> Void
) -> ()

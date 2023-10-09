import Combine
import XCTest

@testable import Wildfront

struct TestState {
    var counter: Int = 0
}

enum TestAction {
    case increment
    case decrement
}

class StoreTests: XCTestCase {
    var store: Store<TestState, TestAction>!

    override func setUp() {
        super.setUp()
        let initialState = TestState()
        let reducer: (inout TestState, TestAction) -> Void = { state, action in
            switch action {
            case .increment:
                state.counter += 1
            case .decrement:
                state.counter -= 1
            }
        }

        store = Store(
            initialState: initialState,
            reducer: reducer)
    }

    func testInitialState() {
        XCTAssertEqual(store.state.counter, 0)
    }

    func testDispatchIncrement() {
        store.dispatch(.increment)
        XCTAssertEqual(store.state.counter, 1)
    }

    func testDispatchDecrement() {
        store.dispatch(.decrement)
        XCTAssertEqual(store.state.counter, -1)
    }

    func testDispatchMultipleActions() {
        store.dispatch(.increment)
        store.dispatch(.increment)
        store.dispatch(.decrement)
        XCTAssertEqual(store.state.counter, 1)
    }
}

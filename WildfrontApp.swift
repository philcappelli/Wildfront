//
//  WildfrontApp.swift
//  Wildfront
//
//  Created by Philip on 10/5/23.
//

import SwiftUI

@main
struct WildfrontApp: App {
    @State private var store = Store(
        initialState: AppState(
            nationalParksState: NationalParksState()
        ),
        middleware: [ nationalParksMiddleware(service: DefaultAPIService()) ],
        reducer: appReducer(state:action:)
    )

    var body: some Scene {
        WindowGroup {
            NationalParksView(store: store)
        }
    }
}

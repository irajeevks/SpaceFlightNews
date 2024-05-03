//
//  SpaceFlightNewsApp.swift
//  SpaceFlightNews
//
//  Created by Rajeev Singh on 02/05/24.
//  Copyright © 2024 Rajeev Singh. All rights reserved.
//

import AppFeature
import ComposableArchitecture
import SwiftUI

@main
struct SpaceFlightNewsApp: App {
    let store: StoreOf<AppFeature> = .init(initialState: .init()) {
        AppFeature()
    }
    
    var body: some Scene {
        WindowGroup {
            AppView(store: store)
        }
    }
}

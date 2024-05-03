//
//  AppView.swift
//  SpaceFlightNews
//
//  Created by Rajeev Singh on 02/05/24.
//  Copyright © 2024 Rajeev Singh. All rights reserved.
//

import AppTabsFeature
import ComposableArchitecture
import Foundation
import SwiftUI

public struct AppView: View {
    let store: StoreOf<AppFeature>
    
    public init(store: StoreOf<AppFeature>) {
        self.store = store
    }
    
    public var body: some View {
        AppTabsView(store: store.scope(state: \.tab, action: \.tab))
    }
}

#Preview {
    AppView(store: .init(initialState: .init(tab: AppTabsFeature.State()), reducer: {
        AppFeature()
    }))
}

//
//  AppFeature.swift
//  SpaceFlightNews
//
//  Created by Rajeev Singh on 02/05/24.
//  Copyright © 2024 Rajeev Singh. All rights reserved.
//

import AppTabsFeature
import ComposableArchitecture
import Foundation

@Reducer
public struct AppFeature {
    @ObservableState
    public struct State: Equatable {
        var tab: AppTabsFeature.State
        
        public init(tab: AppTabsFeature.State = .init()) {
            self.tab = tab
        }
    }
    
    public enum Action: Equatable {
        case tab(AppTabsFeature.Action)
    }
    
    public init() {}
    
    public var body: some ReducerOf<Self> {
        Scope(state: \.tab, action: \.tab) {
            AppTabsFeature()
        }
    }
}

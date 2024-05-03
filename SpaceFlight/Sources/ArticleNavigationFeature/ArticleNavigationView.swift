//
//  ArticleNavigationView.swift
//  SpaceFlightNews
//
//  Created by Rajeev Singh on 02/05/24.
//  Copyright © 2024 Rajeev Singh. All rights reserved.
//

import ArticleDetailsFeature
import ArticlesFeature
import ComposableArchitecture
import Foundation
import Models
import SwiftUI
import UIUtilities

public struct ArticleNavigationView: View {
    @Bindable var store: StoreOf<ArticleNavigationFeature>
    
    public init(store: StoreOf<ArticleNavigationFeature>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            ArticlesView(store: store.scope(state: \.root, action: \.root))
                .navigationTitle(store.root.type.title)
        } destination: { destinationStore in
            DestinationView(store: destinationStore)
        }
    }
    
    struct DestinationView: View {
        let store: StoreOf<ArticleNavigationFeature.Path>
        
        var body: some View {
            switch store.case {
            case .articleDetails(let articleDetailsStore):
                ArticleDetailsView(store: articleDetailsStore)
            }
        }
    }
}

#Preview {
    ArticleNavigationView(store: .init(initialState: ArticleNavigationFeature.State(root: .init(type: .blogs)), reducer: {
        ArticleNavigationFeature()
    }))
}

//
//  AppTabsView.swift
//  SpaceFlightNews
//
//  Created by Rajeev Singh on 02/05/24.
//  Copyright © 2024 Rajeev Singh. All rights reserved.
//

import ArticleNavigationFeature
import ComposableArchitecture
import Foundation
import Models
import SwiftUI
import UIUtilities

public struct AppTabsView: View {
    @Bindable var store: StoreOf<AppTabsFeature>
    
    public init(store: StoreOf<AppTabsFeature>) {
        self.store = store
    }
    
    public var body: some View {
        TabView(selection: $store.tab) {
            ArticleNavigationView(store: store.scope(state: \.articles, action: \.articles))
                .tabItem { Label("Articles", systemImage: "newspaper") }
                .tag(PageType.article)
            
            ArticleNavigationView(store: store.scope(state: \.blogs, action: \.blogs))
                .tabItem { Label("Blogs", systemImage: "book") }
                .tag(PageType.blogs)
            
            ArticleNavigationView(store: store.scope(state: \.reports, action: \.reports))
                .tabItem { Label("Reports", systemImage: "book.pages") }
                .tag(PageType.reports)
        }
    }
}

#Preview {
    AppTabsView(store: .init(initialState: .init(), reducer: {
        AppTabsFeature()
    }))
}

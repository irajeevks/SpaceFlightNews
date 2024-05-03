//
//  AppView.swift
//  SpaceFlightNews
//
//  Created by Rajeev Singh on 02/05/24.
//  Copyright © 2024 Rajeev Singh. All rights reserved.
//

import ArticleNavigationFeature
import ArticlesFeature
import ComposableArchitecture
import Foundation
import Models

@Reducer
public struct AppTabsFeature {
    @ObservableState
    public struct State: Equatable {
        var articles: ArticleNavigationFeature.State
        var blogs: ArticleNavigationFeature.State
        var reports: ArticleNavigationFeature.State
        var tab: PageType = .article
        
        public init(
            articles: ArticleNavigationFeature.State = .init(root: .init(type: .article)),
            blogs: ArticleNavigationFeature.State = .init(root: .init(type: .blogs)),
            reports: ArticleNavigationFeature.State = .init(root: .init(type: .reports)),
            tab: PageType = .article
        ) {
            self.articles = articles
            self.blogs = blogs
            self.reports = reports
            self.tab = tab
        }
    }
    
    public enum Action: Equatable, BindableAction {
        case binding(_ action: BindingAction<State>)
        case articles(ArticleNavigationFeature.Action)
        case blogs(ArticleNavigationFeature.Action)
        case reports(ArticleNavigationFeature.Action)
    }
    
    public init() {}
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        
        Scope(state: \.articles, action: \.articles) {
            ArticleNavigationFeature()
        }
        Scope(state: \.blogs, action: \.blogs) {
            ArticleNavigationFeature()
        }
        Scope(state: \.reports, action: \.reports) {
            ArticleNavigationFeature()
        }
    }
}

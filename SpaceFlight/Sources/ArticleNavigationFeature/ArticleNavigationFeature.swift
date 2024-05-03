//
//  ArticleNavigationFeature.swift
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
import Service
import UIUtilities

@Reducer
public struct ArticleNavigationFeature {
    @Reducer(state: .equatable, action: .equatable)
    public enum Path {
        case articleDetails(ArticleDetailsFeature)
    }
    
    @ObservableState
    public struct State: Equatable {
        public var path: StackState<Path.State>
        public var root: ArticlesFeature.State
        
        public init(root: ArticlesFeature.State = .init(type: .article), path: StackState<Path.State> = .init()) {
            self.root = root
            self.path = path
        }
    }
    
    public enum Action: Equatable {
        case path(StackActionOf<Path>)
        case root(ArticlesFeature.Action)
    }
    
    public init() {}
    
    public var body: some ReducerOf<Self> {
        Scope(state: \.root, action: \.root) {
            ArticlesFeature()
        }
        
        Reduce<State, Action> { state, action in
            switch action {
            case .path:
                return .none
                
            case .root(.delegate(.openArticle(let article))):
                state.path.append(.articleDetails(.init(article: article)))
                return .none
                
            case .root:
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
}

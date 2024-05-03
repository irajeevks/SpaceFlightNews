//
//  ArticlesFeature.swift
//  SpaceFlightNews
//
//  Created by Rajeev Singh on 02/05/24.
//  Copyright © 2024 Rajeev Singh. All rights reserved.
//

import ComposableArchitecture
import FilterFeature
import Foundation
import Models
import Service
import UIUtilities

@Reducer
public struct ArticlesFeature {
    
    @Reducer(state: .equatable, action: .equatable)
    public enum Destination {
        case filter(FilterFeature)
    }
    
    @ObservableState
    public struct State: Equatable {
        public let type: PageType
        var fetchingState: FetchingState<Paginated<Article>>
        @Shared var request: Request
        var articles: [Article] = []
        var isLoadingNext: Bool = false
        @Presents var destination: Destination.State?
        
        public init(
            type: PageType,
            fetchingState: FetchingState<Paginated<Article>> = .fetched(.init(count: 0, results: [])),
            request: Request = .init(limit: 10, offset: 0),
            destination: Destination.State? = nil
        ) {
            self.type = type
            self.fetchingState = fetchingState
            self._request = .init(request)
            self.destination = destination
        }
    }
    
    public enum Action: Equatable {
        case delegate(Delegate)
        case destination(PresentationAction<Destination.Action>)
        case didReceive(FetchingState<Paginated<Article>>)
        case fetchNextPage
        case filterButtonTapped
        case retryButtonTapped
        case openDetail(Article)
        case onAppear
        
        public enum Delegate: Equatable {
            case openArticle(Article)
        }
    }
    
    @Dependency(\.appService) private var service
    
    public init() {}
    
    public var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
            case .delegate:
                return .none
                
            case .destination(.presented(.filter(.delegate(.applyFilter)))):
                state.articles = []
                return .send(.onAppear)
                
            case .destination:
                return .none
                
            case .didReceive(let fetchingState):
                state.fetchingState = fetchingState
                state.isLoadingNext = false
                if let value = fetchingState.value?.results {
                    if state.articles.isEmpty {
                        state.articles = value
                    } else {
                        state.articles.append(contentsOf: value)
                    }
                }
                return .none
                
            case .fetchNextPage:
                state.request.offset = state.articles.count
                state.isLoadingNext = true
                return .send(.onAppear)
                
            case .filterButtonTapped:
                state.destination = .filter(.init(request: state.$request))
                return .none
                
            case .retryButtonTapped:
                return .send(.onAppear)
                
            case .openDetail(let article):
                return .send(.delegate(.openArticle(article)))
                
            case .onAppear:
                guard state.fetchingState.isFetching == false,
                      (state.articles.isEmpty || state.isLoadingNext) else { return .none }
                
                if state.articles.isEmpty {
                    state.fetchingState = .fetching
                }
                let request = state.request
                let type = state.type
                return .run { send in
                    switch type {
                    case .article:
                        let result = try await service.articles(request: request)
                        await send(.didReceive(.fetched(result)))
                    case .blogs:
                        let result = try await service.blogs(request: request)
                        await send(.didReceive(.fetched(result)))
                    case .reports:
                        let result = try await service.reports(request: request)
                        await send(.didReceive(.fetched(result)))
                    }
                    
                } catch: { error, send in
                    await send(.didReceive(.error(error.localizedDescription)))
                }
            }
        }
        .ifLet(\.$destination, action: \.destination)
    }
}

//
//  ArticlesFeatureTests.swift
//  SpaceFlightNews
//
//  Created by Rajeev Singh on 02/05/24.
//  Copyright © 2024 Rajeev Singh. All rights reserved.
//
@testable import ArticlesFeature
@testable import FilterFeature
import ComposableArchitecture
import Models
import XCTest

final class ArticlesFeatureTests: XCTestCase {
    
    enum TestError: LocalizedError {
        case network
        
        var errorDescription: String? {
            switch self {
            case .network:
                return "Network Error"
            }
        }
    }
    
    @MainActor
    func test_Article_OnAppear_NextPage_OpenDetails() async throws {
        let paginatedArticles = Paginated(count: 12, results: [Article].preview)
        let secondPageArticles = Paginated(count: 12, results: [Article.preview])
        
        let store = TestStore(initialState: ArticlesFeature.State(type: .article)) {
            ArticlesFeature()
        } withDependencies: {
            $0.appService.articles = { request in
                if request.offset == 0 {
                    return paginatedArticles
                } else {
                    return secondPageArticles
                }
            }
        }
        
        await store.send(.onAppear) {
            $0.fetchingState = .fetching
        }
        
        await store.receive(.didReceive(.fetched(paginatedArticles))) {
            $0.fetchingState = .fetched(paginatedArticles)
            $0.articles = paginatedArticles.results
        }
        
        await store.send(.fetchNextPage) {
            $0.request.offset = paginatedArticles.results.count
            $0.isLoadingNext = true
        }
        
        await store.receive(.onAppear)
                
        await store.receive(.didReceive(.fetched(secondPageArticles))) {
            $0.isLoadingNext = false
            $0.fetchingState = .fetched(secondPageArticles)
            $0.articles.append(contentsOf: secondPageArticles.results)
        }
        
        await store.send(.openDetail(.preview))
        
        await store.receive(.delegate(.openArticle(.preview)))
    }
    
    @MainActor
    func test_Article_OnAppear_Failure() async throws {
        
        let store = TestStore(initialState: ArticlesFeature.State(type: .article)) {
            ArticlesFeature()
        } withDependencies: {
            $0.appService.articles = { request in
                throw TestError.network
            }
        }
        
        await store.send(.onAppear) {
            $0.fetchingState = .fetching
        }
        
        await store.receive(.didReceive(.error(TestError.network.localizedDescription))) {
            $0.fetchingState = .error(TestError.network.localizedDescription)
        }
    }
    
    @MainActor
    func test_Article_OnAppear_NextPage_Failure() async throws {
        let paginatedArticles = Paginated(count: 12, results: [Article].preview)
        
        let store = TestStore(initialState: ArticlesFeature.State(type: .article)) {
            ArticlesFeature()
        } withDependencies: {
            $0.appService.articles = { request in
                if request.offset == 0 {
                    return paginatedArticles
                } else {
                    throw TestError.network
                }
            }
        }
        
        await store.send(.onAppear) {
            $0.fetchingState = .fetching
        }
        
        await store.receive(.didReceive(.fetched(paginatedArticles))) {
            $0.fetchingState = .fetched(paginatedArticles)
            $0.articles = paginatedArticles.results
        }
        
        await store.send(.fetchNextPage) {
            $0.request.offset = paginatedArticles.results.count
            $0.isLoadingNext = true
        }
        
        await store.receive(.onAppear)
        
        await store.receive(.didReceive(.error(TestError.network.localizedDescription))) {
            $0.fetchingState = .error(TestError.network.localizedDescription)
            $0.isLoadingNext = false
        }
    }
    
    @MainActor
    func test_Article_FilterButton() async throws {
        let request = Request()
        let paginatedArticles = Paginated(count: 1, results: [Article.preview])
        let store = TestStore(initialState: ArticlesFeature.State(type: .article, fetchingState: .fetched(paginatedArticles), request: request)) {
            ArticlesFeature()
        } withDependencies: {
            $0.appService.articles = { request in
                return paginatedArticles
            }
            $0.dismiss = .init({})
        }
        
        await store.send(.filterButtonTapped) {
            $0.destination = .filter(.init(request: .init(request)))
        }
        
        await store.send(.destination(.presented(.filter(.set(\.request.isFeatured, true))))) {
            $0.request.isFeatured = true
        }
        
        await store.send(.destination(.presented(.filter(.applyButtonTapped))))
        
        await store.receive(.destination(.presented(.filter(.delegate(.applyFilter)))))
        await store.receive(.onAppear) {
            $0.fetchingState = .fetching
        }
        
        await store.receive(.destination(.dismiss)) {
            $0.destination = nil
        }
        
        await store.receive(.didReceive(.fetched(paginatedArticles))) {
            $0.fetchingState = .fetched(paginatedArticles)
            $0.articles = paginatedArticles.results
        }
    }
}

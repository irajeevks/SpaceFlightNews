//
//  AppTabFeatureTests.swift
//  SpaceFlightNews
//
//  Created by Rajeev Singh on 02/05/24.
//  Copyright © 2024 Rajeev Singh. All rights reserved.
//

@testable import AppTabsFeature
@testable import ArticleNavigationFeature
@testable import ArticlesFeature
@testable import FilterFeature
import ComposableArchitecture
import Models
import XCTest

final class AppTabsFeatureTests: XCTestCase {
    
    @MainActor
    func test_TabSelection() async throws {
        let paginatedArticles = Paginated(count: 1, results: [Article].preview)
        let pagintedBlogs = Paginated(count: 1, results: [Article].preview)
        let pagintedReports = Paginated(count: 1, results: [Article].preview)
        let store = TestStore(
            initialState: AppTabsFeature.State(
                articles: .init(root: .init(type: .article, fetchingState: .fetched(paginatedArticles))),
                blogs: .init(root: .init(type: .blogs, fetchingState: .fetched(pagintedBlogs))),
                reports: .init(root: .init(type: .reports, fetchingState: .fetched(pagintedReports))),
                tab: .reports
            )) {
                AppTabsFeature()
            }
        
        await store.send(.set(\.tab, .article)) {
            $0.tab = .article
        }
        
        await store.send(.set(\.tab, .blogs)) {
            $0.tab = .blogs
        }
        
        await store.send(.set(\.tab, .reports)) {
            $0.tab = .reports
        }
    }
    
    @MainActor
    func test_Tab_Filter_Integration() async throws {
        let paginatedArticles = Paginated(count: 1, results: [Article].preview)
        let pagintedBlogs = Paginated(count: 1, results: [Article].preview)
        let pagintedReports = Paginated(count: 1, results: [Article].preview)
        let store = TestStore(
            initialState: AppTabsFeature.State(
                articles: .init(root: .init(type: .article, fetchingState: .fetched(paginatedArticles))),
                blogs: .init(root: .init(type: .blogs, fetchingState: .fetched(pagintedBlogs))),
                reports: .init(root: .init(type: .reports, fetchingState: .fetched(pagintedReports))),
                tab: .reports
            )) {
                AppTabsFeature()
            }

        await store.send(.articles(.root(.filterButtonTapped))) {
            $0.articles.root.destination = .filter(.init(request: .init($0.articles.root.request)))
        }
        
        await store.send(.articles(.root(.destination(.presented(.filter(.set(\.request.limit, 10))))))) {
            $0.articles.root.request.limit = 10
        }
        
        await store.send(.blogs(.root(.filterButtonTapped))) {
            $0.blogs.root.destination = .filter(.init(request: .init($0.blogs.root.request)))
        }
        
        await store.send(.blogs(.root(.destination(.presented(.filter(.set(\.request.limit, 5))))))) {
            $0.blogs.root.request.limit = 5
            $0.articles.root.request.limit = 10
        }
        
        await store.send(.reports(.root(.filterButtonTapped))) {
            $0.reports.root.destination = .filter(.init(request: .init($0.reports.root.request)))
        }
        
        await store.send(.reports(.root(.destination(.presented(.filter(.set(\.request.isFeatured, true))))))) {
            $0.blogs.root.request.limit = 5
            $0.articles.root.request.limit = 10
            $0.reports.root.request.isFeatured = true
        }
    }
}

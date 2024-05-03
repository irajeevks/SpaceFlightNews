//
//  ArticleNavigationFeatureTests.swift
//  SpaceFlightNews
//
//  Created by Rajeev Singh on 02/05/24.
//  Copyright © 2024 Rajeev Singh. All rights reserved.
//

@testable import ArticleNavigationFeature
import ComposableArchitecture
import Models
import XCTest

final class ArticleNavigationFeatureTests: XCTestCase {
    
    @MainActor
    func testNavigation() async throws {
        let store = TestStore(initialState: ArticleNavigationFeature.State(
            root: .init(
                type: .blogs,
                fetchingState: .fetched(.init(count: 1, results: [Article.preview])))
        )) {
            ArticleNavigationFeature()
        }
        
        await store.send(.root(.openDetail(.preview)))
        await store.receive(.root(.delegate(.openArticle(.preview)))) {
            $0.path[id: 0] = .articleDetails(.init(article: .preview))
        }
    }
}

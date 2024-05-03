//
//  FilterFeatureTests.swift
//  SpaceFlightNews
//
//  Created by Rajeev Singh on 02/05/24.
//  Copyright © 2024 Rajeev Singh. All rights reserved.
//

import ComposableArchitecture
@testable import FilterFeature
import Models
import XCTest

final class FilterFeatureTests: XCTestCase {
    
    @MainActor
    func testForm() async throws {
        let store = TestStore(initialState: FilterFeature.State(request: .init(Request()))) {
            FilterFeature()
        }
        
        await store.send(.set(\.request.limit, 20)) {
            $0.request.limit = 20
        }
        
        await store.send(.set(\.request.hasEvent, true)) {
            $0.request.hasEvent = true
        }
        
        await store.send(.set(\.request.hasLaunch, true)) {
            $0.request.hasLaunch = true
        }
        
        await store.send(.set(\.request.isFeatured, true)) {
            $0.request.isFeatured = true
        }
    }
    
    @MainActor
    func testFormReset() async throws {
        let request = Request(hasEvent: true, hasLaunch: false, isFeatured: true, limit: 5)
        let store = TestStore(initialState: FilterFeature.State(request: .init(request))) {
            FilterFeature()
        }
        
        await store.send(.resetButtonTapped) {
            $0.request = .init(limit: 10, offset: 0)
        }
        
        await store.send(.set(\.request.limit, 25)) {
            $0.request.limit = 25
        }
        
        await store.send(.set(\.request.isFeatured, true)) {
            $0.request.isFeatured = true
        }
        
        await store.send(.resetButtonTapped) {
            $0.request = .init(limit: 10, offset: 0)
        }
    }
    
    @MainActor
    func testFormApply() async throws {
        let request = Request(hasEvent: true, hasLaunch: false, isFeatured: true, limit: 5)
        let store = TestStore(initialState: FilterFeature.State(request: .init(request))) {
            FilterFeature()
        } withDependencies: {
            $0.dismiss = .init({})
        }
        
        await store.send(.set(\.request.limit, 15)) {
            $0.request.limit = 15
        }
        
        await store.send(.set(\.request.isFeatured, true)) {
            $0.request.isFeatured = true
        }
        
        await store.send(.applyButtonTapped)
        
        await store.receive(.delegate(.applyFilter))
    }

}

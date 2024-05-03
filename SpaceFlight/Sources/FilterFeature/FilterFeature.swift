//
//  FilterFeature.swift
//  SpaceFlightNews
//
//  Created by Rajeev Singh on 02/05/24.
//  Copyright © 2024 Rajeev Singh. All rights reserved.
//

import ComposableArchitecture
import Foundation
import Models

@Reducer
public struct FilterFeature {
    @ObservableState
    public struct State: Equatable {
        @Shared var request: Request
        
        public init(request: Shared<Request>) {
            self._request = request
        }
    }
    
    public enum Action: Equatable, BindableAction {
        case applyButtonTapped
        case binding(_ action: BindingAction<State>)
        case delegate(Delegate)
        case resetButtonTapped
        
        public enum Delegate: Equatable {
            case applyFilter
        }
    }
    
    @Dependency(\.dismiss) private var dismiss
    
    public init() {}
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce<State, Action> { state, action in
            switch action {
            case .applyButtonTapped:
                return .send(.delegate(.applyFilter))
                    .concatenate(with: .run(operation: { send in
                        await dismiss()
                    }))
                
            case .binding:
                return .none
                
            case .delegate:
                return .none
                
            case .resetButtonTapped:
                state.request = .init(limit: 10, offset: 0)
                return .none
            }
        }
    }
}

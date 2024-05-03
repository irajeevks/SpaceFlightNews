//
//  FilterView.swift
//  SpaceFlightNews
//
//  Created by Rajeev Singh on 02/05/24.
//  Copyright © 2024 Rajeev Singh. All rights reserved.
//
import ComposableArchitecture
import Foundation
import Models
import SwiftUI

public struct FilterView: View {
    @Bindable var store: StoreOf<FilterFeature>
    
    public init(store: StoreOf<FilterFeature>) {
        self.store = store
    }
    
    public var body: some View {
        Form {
            LabeledContent("Limit") {
                TextField("Enter Limit", text: $store.request.limit.with(default: 10).toString())
            }
            .keyboardType(.numberPad)
            
            Toggle("Has Event", isOn: $store.request.hasEvent.with(default: false))
            
            Toggle("Has Launch", isOn: $store.request.hasLaunch.with(default: false))
            
            Toggle("Is Featured", isOn: $store.request.isFeatured.with(default: false))
            
        }
        .labeledContentStyle(FormLabeledContentStyle())
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(role: .cancel) {
                    store.send(.resetButtonTapped)
                } label: {
                    Text("Reset")
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    store.send(.applyButtonTapped)
                } label: {
                    Text("Apply")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        FilterView(store: .init(initialState: FilterFeature.State(request: .init(Request())), reducer: {
            FilterFeature()
        }))
        .navigationTitle("Filter Blogs")
    }
}

extension Binding {
    func map<T>(_ g: @escaping (Value) -> T, s: @escaping (T) -> (Value)) -> Binding<T> {
        Binding<T> {
            g(wrappedValue)
        } set: { newValue in
            wrappedValue = s(newValue)
        }
    }
}

extension Binding {
    func with<T>(default value: T) -> Binding<T> where Value == Optional<T> {
        Binding<T> {
            return wrappedValue ?? value
        } set: { newValue in
            wrappedValue = newValue
        }
    }
}

extension Binding where Value == Int {
    func toString() -> Binding<String> {
        Binding<String> {
            "\(self.wrappedValue)"
        } set: { newValue in
            self.wrappedValue = Int(newValue) ?? 0
        }
    }
}

struct FormLabeledContentStyle: LabeledContentStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
                .foregroundStyle(.secondary)
            configuration.content
                .multilineTextAlignment(.trailing)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

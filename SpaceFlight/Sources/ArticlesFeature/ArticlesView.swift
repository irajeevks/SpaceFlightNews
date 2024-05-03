//
//  ArticlesView.swift
//  SpaceFlightNews
//
//  Created by Rajeev Singh on 02/05/24.
//  Copyright © 2024 Rajeev Singh. All rights reserved.
//

import ComposableArchitecture
import FilterFeature
import Foundation
import Models
import UIUtilities
import SwiftUI

public struct ArticlesView: View {
    @Bindable var store: StoreOf<ArticlesFeature>
    
    public init(store: StoreOf<ArticlesFeature>) {
        self.store = store
    }
    
    public var body: some View {
        FetchingView(state: store.fetchingState, title: store.type.title) { paginatedResult in
            if store.articles.isEmpty {
                VStack(spacing: 16) {
                    Image(systemName: "book")
                        .font(.system(size: 120))
                        .symbolVariant(.slash)
                        .foregroundStyle(.secondary)
                    Text("No Articles yet.")
                        .font(.title2)
                        
                    Text("No articles are found yet from the remote server. Please try again")
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.secondary)
                    
                    Button {
                        store.send(.retryButtonTapped, animation: .smooth)
                    } label: {
                        Text("Retry")
                            .bold()
                    }
                    .buttonStyle(.bordered)
                }
                .padding()
                .transition(.scale.combined(with: .opacity))
            } else {
                List {
                    ForEach(store.articles, id: \.id) { article in
                        Button {
                            store.send(.openDetail(article))
                        } label: {
                            ArticleItemView(article: article)
                        }
                    }
                    if paginatedResult.next != nil {
                        HStack(spacing: 8) {
                            ProgressView()
                                .id(UUID())
                            Text("Fetching next page...")
                        }
                        .frame(maxWidth: .infinity)
                        .onAppear {
                            store.send(.fetchNextPage)
                        }
                    }
                }
                .listStyle(.plain)
            }
        }
        .onAppear {
            store.send(.onAppear)
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    store.send(.filterButtonTapped)
                } label: {
                    Label("Filter", systemImage: "line.3.horizontal.decrease.circle")
                }
            }
        }
        .sheet(item: $store.scope(state: \.destination, action: \.destination)) { destinationStore in
            DestinationView(store: destinationStore, type: store.type)
        }
    }
    
    struct ArticleItemView: View {
        let article: Article
        
        var body: some View {
            VStack(alignment: .leading) {
                Rectangle()
                    .fill(Color.gray.opacity(0.25))
                    .aspectRatio(16/12, contentMode: .fit)
                    .overlay {
                        AppAsyncImage(url: URL(string: article.imageURL)!)
                            .aspectRatio(contentMode: .fill)
                    }
                    .clipShape(.rect(cornerRadius: 8, style: .continuous))
                    .overlay(alignment: .topLeading) {
                        if article.featured ?? false {
                            Text("Featured")
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Material.thin, in: .rect(cornerRadius: 6, style: .continuous))
                                .padding(4)
                        }
                    }
                    .overlay(alignment: .bottomLeading) {
                        Text(article.title)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .padding(8)
                            .padding(.horizontal, 4)
                            .lineLimit(2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Material.ultraThin, in: .rect(cornerRadius: 8, style: .continuous))
                    }
            }
        }
    }
    
    struct DestinationView: View {
        let store: StoreOf<ArticlesFeature.Destination>
        let type: PageType
        
        var body: some View {
            switch store.case {
            case .filter(let filterStore):
                NavigationStack {
                    FilterView(store: filterStore)
                        .navigationTitle("Filter \(type.title)")
                }
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
            }
        }
    }
}

#Preview {
    NavigationStack {
        ArticlesView(store: .init(initialState: .init(type: .blogs), reducer: {
            ArticlesFeature()
        }, withDependencies: {
            $0.appService.blogs = { request in
                if request.isFeatured ?? false {
                    return .init(count: 1, results: [])
                } else if let limit = request.limit {
                    return .init(count: 1, results: Array([Article].preview.prefix(limit)))
                } else {
                    return .init(count: 1, results: .preview)
                }
            }
        }))
    }
    .preferredColorScheme(.dark)
}

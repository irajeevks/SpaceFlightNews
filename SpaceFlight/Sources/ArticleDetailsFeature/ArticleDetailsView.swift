//
//  ArticleDetailsView.swift
//  SpaceFlightNews
//
//  Created by Rajeev Singh on 02/05/24.
//  Copyright © 2024 Rajeev Singh. All rights reserved.
//

import ComposableArchitecture
import Foundation
import Models
import SwiftUI
import UIUtilities

public struct ArticleDetailsView: View {
    let store: StoreOf<ArticleDetailsFeature>
    
    public init(store: StoreOf<ArticleDetailsFeature>) {
        self.store = store
    }
    
    public var body: some View {
        List {
            Text(store.article.title)
                .font(.title)
            AppAsyncImage(url: URL(string: store.article.imageURL)!)
                .aspectRatio(contentMode: .fit)
                .clipShape(.rect(cornerRadius: 12, style: .continuous))
            
            let publishedAt = store.article.publishedAt
            LabeledContent("Published at", value: "\((try? Date(publishedAt, strategy: .iso8601).formatted()) ?? "")")
            
            if let summary = store.article.summary {
                Text(summary)
            }
        }
        .listStyle(.plain)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ArticleDetailsView(store: .init(initialState: .init(article: Article(id: 1, title: "Article", url: "", imageURL: "", newsSite: "", publishedAt: "", updatedAt: "")), reducer: {
        ArticleDetailsFeature()
    }))
}

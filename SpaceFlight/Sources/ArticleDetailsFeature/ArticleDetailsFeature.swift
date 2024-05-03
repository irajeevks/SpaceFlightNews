//
//  ArticleDetailsFeature.swift
//  SpaceFlightNews
//
//  Created by Rajeev Singh on 02/05/24.
//  Copyright © 2024 Rajeev Singh. All rights reserved.
//

import ComposableArchitecture
import Foundation
import Models
import UIUtilities

@Reducer
public struct ArticleDetailsFeature {
    @ObservableState
    public struct State: Equatable {
        let article: Article
        
        public init(article: Article) {
            self.article = article
        }
    }
    
    public init() {}
}

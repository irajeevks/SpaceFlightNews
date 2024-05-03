//
//  PageType.swift
//  SpaceFlightNews
//
//  Created by Rajeev Singh on 02/05/24.
//  Copyright © 2024 Rajeev Singh. All rights reserved.
//

import Foundation

public enum PageType {
    case article
    case blogs
    case reports
    
    public var title: String {
        switch self {
        case .article:
            return "Articles"
        case .blogs:
            return "Blogs"
        case .reports:
            return "Reports"
        }
    }
}

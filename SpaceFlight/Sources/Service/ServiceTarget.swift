//
//  File.swift
//  SpaceFlightNews
//
//  Created by Rajeev Singh on 02/05/24.
//  Copyright © 2024 Rajeev Singh. All rights reserved.
//

import Alamofire
import AppService
import Foundation
import Models
import Moya

public enum ServiceTarget: PathProvider {
    case articles
    case article(id: Int)
    case blogs
    case blog(id: Int)
    case info
    case reports
    case report(id: Int)
    
    public var path: String {
        switch self {
        case .articles:
            return "v4/articles"
        case .article(let id):
            return "v4/articles/\(id)"
        case .blogs:
            return "v4/blogs"
        case .blog(let id):
            return "v4/blogs/\(id)"
        case .info:
            return "v4/info"
        case .reports:
            return "v4/reports"
        case .report(let id):
            return "v4/reports/\(id)"
        }
    }
}

extension AppService {
    func articles(request: Models.Request) async throws -> Paginated<Article> {
        try await self.fetch(path: ServiceTarget.articles, method: .get, queries: request.queryItems)
    }
    
    func article(id: Int) async throws -> Article {
        try await self.fetch(path: ServiceTarget.article(id: id), method: .get)
    }
    
    func blogs(request: Models.Request) async throws -> Paginated<Article> {
        try await self.fetch(path: ServiceTarget.blogs, method: .get, queries: request.queryItems)
    }
    
    func blog(id: Int) async throws -> Article {
        try await self.fetch(path: ServiceTarget.blog(id: id), method: .get)
    }
    
    func info() async throws -> Info {
        try await self.fetch(path: ServiceTarget.info, method: .get)
    }
    
    func reports(request: Models.Request) async throws -> Paginated<Article> {
        try await self.fetch(path: ServiceTarget.reports, method: .get, queries: request.queryItems)
    }
    
    func report(id: Int) async throws -> Article {
        try await self.fetch(path: ServiceTarget.report(id: id), method: .get)
    }
}

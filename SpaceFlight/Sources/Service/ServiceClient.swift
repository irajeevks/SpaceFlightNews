//
//  ServiceClient.swift
//  SpaceFlightNews
//
//  Created by Rajeev Singh on 02/05/24.
//  Copyright © 2024 Rajeev Singh. All rights reserved.
//

import AppService
import ComposableArchitecture
import Foundation
import Models

@DependencyClient
public struct ServiceClient {
    public var articles: (_ request: Request) async throws -> Paginated<Article>
    public var article: (_ id: Int) async throws -> Article
    public var blogs: (_ request: Request) async throws -> Paginated<Article>
    public var blog: (_ id: Int) async throws -> Article
    public var info: () async throws -> Info
    public var reports: (_ request: Request) async throws -> Paginated<Article>
    public var report: (_ id: Int) async throws -> Article
}

extension ServiceClient: DependencyKey {
    public static var liveValue: ServiceClient = {
        let liveService = AppService(
            baseURL: URL(string: "https://api.spaceflightnewsapi.net")!
        )
        
        return .init { request in
            try await liveService.articles(request: request)
        } article: { id in
            try await liveService.article(id: id)
        } blogs: { request in
            try await liveService.blogs(request: request)
        } blog: { id in
            try await liveService.blog(id: id)
        } info: {
            try await liveService.info()
        } reports: { request in
            try await liveService.reports(request: request)
        } report: { id in
            try await liveService.report(id: id)
        }
    }()
}

extension DependencyValues {
    public var appService: ServiceClient {
        get { self[ServiceClient.self] }
        set { self[ServiceClient.self] = newValue }
    }
}

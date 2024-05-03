//
//  AppService.swift
//  SpaceFlightNews
//
//  Created by Rajeev Singh on 02/05/24.
//  Copyright © 2024 Rajeev Singh. All rights reserved.
//

import AppService
import Foundation
import Moya

class AppService: Service<AppTarget> {
    var baseURL: URL
    
    init(baseURL: URL) {
        self.baseURL = baseURL
        super.init()
    }
    
    public func fetch<T: Codable>(
        path: PathProvider,
        method: Moya.Method,
        queries: [URLQueryItem] = [],
        request: Encodable? = nil,
        auth: AuthorizationType? = .none
    ) async throws -> T {
        var task: Moya.Task = .requestPlain
        if let request {
            if method == .get {
                task = .requestParameters(
                    parameters: request.dictionary,
                    encoding: URLEncoding.default
                )
            } else {
                task = .requestJSONEncodable(request)
            }
        }
        return try await self.fetch(
            AppTarget(
                url: self.baseURL,
                path: path.path,
                method: method,
                task: task,
                queries: queries,
                authType: auth
            ))
    }
}

extension Encodable {
    var dictionary: [String: Any] {
        let data = try! JSONEncoder().encode(self)
        let item = try! JSONSerialization.jsonObject(
            with: data, options: [.mutableContainers, .fragmentsAllowed, .mutableLeaves])
        return item as! [String: Any]
    }
}

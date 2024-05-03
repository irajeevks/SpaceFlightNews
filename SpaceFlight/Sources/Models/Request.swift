//
//  Request.swift
//  SpaceFlightNews
//
//  Created by Rajeev Singh on 02/05/24.
//  Copyright © 2024 Rajeev Singh. All rights reserved.
//

import Foundation

public struct Request: Codable, Equatable {
    public var event: [Int]?
    public var hasEvent: Bool?
    public var hasLaunch: Bool?
    public var isFeatured: Bool?
    public var launch: [String]?
    public var limit: Int?
    public var newsSite: String?
    public var newsSiteExclude: String?
    public var offset: Int?
    public var ordering: String?
    public var search: String?
    public var summaryContains: String?
    public var summaryContainsAll: String?
    public var summaryContainsOne: String?
    public var titleContains: String?
    public var titleContainsAll: String?
    public var titleContainsOne: String?

    public enum CodingKeys: String, CodingKey {
        case event = "event"
        case hasEvent = "has_event"
        case hasLaunch = "has_launch"
        case isFeatured = "is_featured"
        case launch = "launch"
        case limit = "limit"
        case newsSite = "news_site"
        case newsSiteExclude = "news_site_exclude"
        case offset = "offset"
        case ordering = "ordering"
        case search = "search"
        case summaryContains = "summary_contains"
        case summaryContainsAll = "summary_contains_all"
        case summaryContainsOne = "summary_contains_one"
        case titleContains = "title_contains"
        case titleContainsAll = "title_contains_all"
        case titleContainsOne = "title_contains_one"
    }
    
    public init(event: [Int]? = nil, hasEvent: Bool? = nil, hasLaunch: Bool? = nil, isFeatured: Bool? = nil, launch: [String]? = nil, limit: Int? = nil, newsSite: String? = nil, newsSiteExclude: String? = nil, offset: Int? = nil, ordering: String? = nil, search: String? = nil, summaryContains: String? = nil, summaryContainsAll: String? = nil, summaryContainsOne: String? = nil, titleContains: String? = nil, titleContainsAll: String? = nil, titleContainsOne: String? = nil) {
        self.event = event
        self.hasEvent = hasEvent
        self.hasLaunch = hasLaunch
        self.isFeatured = isFeatured
        self.launch = launch
        self.limit = limit
        self.newsSite = newsSite
        self.newsSiteExclude = newsSiteExclude
        self.offset = offset
        self.ordering = ordering
        self.search = search
        self.summaryContains = summaryContains
        self.summaryContainsAll = summaryContainsAll
        self.summaryContainsOne = summaryContainsOne
        self.titleContains = titleContains
        self.titleContainsAll = titleContainsAll
        self.titleContainsOne = titleContainsOne
    }
    
    public var queryItems: [URLQueryItem] {
        var items: [URLQueryItem] = []
        
        if let event = self.event, let key = CodingKeys(rawValue: "event") {
            items.append(URLQueryItem(name: key.rawValue, value: "\(event)"))
        }
        if let hasEvent = self.hasEvent, let key = CodingKeys(rawValue: "hasEvent") {
            items.append(URLQueryItem(name: key.rawValue, value: "\(hasEvent)"))
        }
        if let hasLaunch = self.hasLaunch, let key = CodingKeys(rawValue: "hasLaunch") {
            items.append(URLQueryItem(name: key.rawValue, value: "\(hasLaunch)"))
        }
        if let isFeatured = self.isFeatured, let key = CodingKeys(rawValue: "isFeatured") {
            items.append(URLQueryItem(name: key.rawValue, value: "\(isFeatured)"))
        }
        if let launch = self.launch, let key = CodingKeys(rawValue: "launch") {
            items.append(URLQueryItem(name: key.rawValue, value: "\(launch)"))
        }
        if let limit = self.limit, let key = CodingKeys(rawValue: "limit") {
            items.append(URLQueryItem(name: key.rawValue, value: "\(limit)"))
        }
        if let newsSite = self.newsSite, let key = CodingKeys(rawValue: "newsSite") {
            items.append(URLQueryItem(name: key.rawValue, value: "\(newsSite)"))
        }
        if let newsSiteExclude = self.newsSiteExclude, let key = CodingKeys(rawValue: "newsSiteExclude") {
            items.append(URLQueryItem(name: key.rawValue, value: "\(newsSiteExclude)"))
        }
        if let offset = self.offset, let key = CodingKeys(rawValue: "offset") {
            items.append(URLQueryItem(name: key.rawValue, value: "\(offset)"))
        }
        if let ordering = self.ordering, let key = CodingKeys(rawValue: "ordering") {
            items.append(URLQueryItem(name: key.rawValue, value: "\(ordering)"))
        }
        if let search = self.search, let key = CodingKeys(rawValue: "search") {
            items.append(URLQueryItem(name: key.rawValue, value: "\(search)"))
        }
        if let summaryContains = self.summaryContains, let key = CodingKeys(rawValue: "summaryContains") {
            items.append(URLQueryItem(name: key.rawValue, value: "\(summaryContains)"))
        }
        if let summaryContainsAll = self.summaryContainsAll, let key = CodingKeys(rawValue: "summaryContainsAll") {
            items.append(URLQueryItem(name: key.rawValue, value: "\(summaryContainsAll)"))
        }
        if let summaryContainsOne = self.summaryContainsOne, let key = CodingKeys(rawValue: "summaryContainsOne") {
            items.append(URLQueryItem(name: key.rawValue, value: "\(summaryContainsOne)"))
        }
        if let titleContains = self.titleContains, let key = CodingKeys(rawValue: "titleContains") {
            items.append(URLQueryItem(name: key.rawValue, value: "\(titleContains)"))
        }
        if let titleContainsAll = self.titleContainsAll, let key = CodingKeys(rawValue: "titleContainsAll") {
            items.append(URLQueryItem(name: key.rawValue, value: "\(titleContainsAll)"))
        }
        if let titleContainsOne = self.titleContainsOne, let key = CodingKeys(rawValue: "titleContainsOne") {
            items.append(URLQueryItem(name: key.rawValue, value: "\(titleContainsOne)"))
        }
        
        return items
    }
}

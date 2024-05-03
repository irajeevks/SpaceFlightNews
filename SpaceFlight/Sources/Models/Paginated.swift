//
//  Paginated.swift
//  SpaceFlightNews
//
//  Created by Rajeev Singh on 02/05/24.
//  Copyright © 2024 Rajeev Singh. All rights reserved.
//

import Foundation

public struct Paginated<T: Codable & Equatable>: Codable, Equatable {
    public var count: Int
    public var next: String?
    public var previous: String?
    public var results: [T]
    
    public init(count: Int, next: String? = nil, previous: String? = nil, results: [T]) {
        self.count = count
        self.next = next
        self.previous = previous
        self.results = results
    }
}

//
//  Info.swift
//  SpaceFlightNews
//
//  Created by Rajeev Singh on 02/05/24.
//  Copyright © 2024 Rajeev Singh. All rights reserved.
//

import Foundation

public struct Info: Codable, Equatable {
    public var version: String
    public var newsSites: [String]
    
    public init(version: String, newsSites: [String]) {
        self.version = version
        self.newsSites = newsSites
    }
    
    public enum CodingKeys: String, CodingKey {
        case version
        case newsSites = "news_sites"
    }
}

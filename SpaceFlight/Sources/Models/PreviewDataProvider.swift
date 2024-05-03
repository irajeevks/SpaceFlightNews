//
//  PreviewDataProvider.swift
//  SpaceFlightNews
//
//  Created by Rajeev Singh on 02/05/24.
//  Copyright © 2024 Rajeev Singh. All rights reserved.
//

import Foundation

public protocol PreviewDataProvider {
    associatedtype T: Codable
    static var previewData: String { get }
    static var preview: T { get }
}

enum Coders {
    static var jsonDecoder: JSONDecoder = {
        JSONDecoder()
    }()
}

extension PreviewDataProvider {
    public static var preview: T {
        guard let data = self.previewData.data(using: .utf8) else { fatalError() }
        return try! Coders.jsonDecoder.decode(T.self, from: data)
    }
}

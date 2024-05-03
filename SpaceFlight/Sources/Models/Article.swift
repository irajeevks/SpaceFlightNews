//
//  Article.swift
//  SpaceFlightNews
//
//  Created by Rajeev Singh on 02/05/24.
//  Copyright © 2024 Rajeev Singh. All rights reserved.
//

import Foundation

public struct Launch: Codable, Equatable {
    public var launchId: String
    public var provider: String
    
    public init(launchId: String, provider: String) {
        self.launchId = launchId
        self.provider = provider
    }
    
    public enum CodingKeys: String, CodingKey {
        case launchId = "launch_id"
        case provider
    }
}

public struct Event: Codable, Equatable {
    public var eventId: Int
    public var provider: String
    
    public init(eventId: Int, provider: String) {
        self.eventId = eventId
        self.provider = provider
    }
    
    public enum CodingKeys: String, CodingKey {
        case eventId = "event_id"
        case provider
    }

}

public struct Article: Codable, Equatable {
    public var id: Int
    public var title: String
    public var url: String
    public var imageURL: String
    public var newsSite: String
    public var summary: String?
    public var publishedAt: String
    public var updatedAt: String
    public var featured: Bool?
    public var launches: [Launch]?
    public var events: [Event]?
    
    public init(id: Int, title: String, url: String, imageURL: String, newsSite: String, summary: String? = nil, publishedAt: String, updatedAt: String, featured: Bool? = nil, launches: [Launch]? = nil, events: [Event]? = nil) {
        self.id = id
        self.title = title
        self.url = url
        self.imageURL = imageURL
        self.newsSite = newsSite
        self.summary = summary
        self.publishedAt = publishedAt
        self.updatedAt = updatedAt
        self.featured = featured
        self.launches = launches
        self.events = events
    }
    
    public enum CodingKeys: String, CodingKey {
        case id
        case title
        case url
        case imageURL = "image_url"
        case newsSite = "news_site"
        case summary
        case publishedAt = "published_at"
        case updatedAt = "updated_at"
        case featured
        case launches
        case events
    }
}

extension Article {
    public static var preview: Article {
        .init(
            id: 100,
            title: "Title",
            url: "url",
            imageURL: "imageurl",
            newsSite: "site",
            publishedAt: "",
            updatedAt: ""
        )
    }
}

extension Array: PreviewDataProvider where Element == Article {
    public typealias T = Self
    
    public static var previewData: String {
        """
        [{"id":23386,"title":"NASA inspector general report highlights issues with Orion heat shield","url":"https://spacenews.com/nasa-inspector-general-report-highlights-issues-with-orion-heat-shield/","image_url":"https://i0.wp.com/spacenews.com/wp-content/uploads/2023/03/orion-inspections.jpg","news_site":"SpaceNews","summary":"A report by NASA’s inspector general has disclosed new details about problems with the Orion spacecraft’s heat shield and other issues that delayed its first crewed launch.","published_at":"2024-05-02T11:05:23Z","updated_at":"2024-05-02T11:13:07.482273Z","featured":false,"launches":[],"events":[]},{"id":23383,"title":"Nelson lobbies Congress to fund ISS deorbit vehicle in supplemental spending bill","url":"https://spacenews.com/nelson-lobbies-congress-to-fund-iss-deorbit-vehicle-in-supplemental-spending-bill/","image_url":"https://i0.wp.com/spacenews.com/wp-content/uploads/2024/05/53689064087_72838e59ed_k.jpg","news_site":"SpaceNews","summary":"NASA Administrator Bill Nelson told a House committee that budget caps forced cuts to agency programs while pleading with them to include money for a space station deorbit vehicle in a supplemental funding bill.","published_at":"2024-05-01T23:50:26Z","updated_at":"2024-05-01T23:53:07.039739Z","featured":false,"launches":[],"events":[]},{"id":23384,"title":"Lawmaker presses Pentagon official on Russia’s potential space nuke","url":"https://spacenews.com/lawmaker-presses-pentagon-official-on-russias-potential-space-nuke/","image_url":"https://i0.wp.com/spacenews.com/wp-content/uploads/2024/05/Screenshot-2024-05-01-at-7.26.39%E2%80%AFPM.png","news_site":"SpaceNews","summary":"Assistant Secretary of Defense for Space Policy John Plumb said more studies are needed to assess the potential impact of a nuclear detonation in space","published_at":"2024-05-01T23:46:53Z","updated_at":"2024-05-01T23:53:07.063625Z","featured":false,"launches":[],"events":[]},{"id":23382,"title":"BAE Systems wins $365 million contract to build geostationary weather instrument","url":"https://spacenews.com/bae-systems-wins-365-million-contract-to-build-geostationary-weather-instrument/","image_url":"https://i0.wp.com/spacenews.com/wp-content/uploads/2023/01/rsz_1screen_shot_2023-01-10_at_115152_am-1.png","news_site":"SpaceNews","summary":"BAE Systems, the former Ball Aerospace and Technologies Corp., won a $365 million contract May 1 to develop an air quality sensor for a U.S. geostationary weather satellites.","published_at":"2024-05-01T21:52:35Z","updated_at":"2024-05-01T21:53:07.108458Z","featured":false,"launches":[],"events":[]},{"id":23381,"title":"NRO’s first batch of next-generation spy satellites set for launch","url":"https://spacenews.com/nros-first-batch-of-next-generation-spy-satellites-set-for-launch/","image_url":"https://i0.wp.com/spacenews.com/wp-content/uploads/2024/05/GJ8YQCJX0AAq9WH-1.jpeg","news_site":"SpaceNews","summary":"The agency’s principal deputy director Troy Meink said the NRO is targeting a May 19 launch of NROL-146","published_at":"2024-05-01T21:04:41Z","updated_at":"2024-05-01T21:13:07.258865Z","featured":false,"launches":[],"events":[]},{"id":23380,"title":"A religious test for space exploration?","url":"https://spacenews.com/religious-test-space-exploration/","image_url":"https://i0.wp.com/spacenews.com/wp-content/uploads/2024/05/4Y9A8677-scaled.jpg","news_site":"SpaceNews","summary":"As we move off planet Earth, we will take all our celebrations, rituals and memorials with us, including our funerals and our memorial services, even as we create new ones","published_at":"2024-05-01T17:53:02Z","updated_at":"2024-05-01T17:53:07.688323Z","featured":false,"launches":[],"events":[]},{"id":23379,"title":"Rocket Lab prepares for back-to-back launches for NASA","url":"https://www.teslarati.com/rocket-lab-prepares-back-to-back-launches-nasa/","image_url":"https://www.teslarati.com/wp-content/uploads/2023/07/53054363868_648bd94c00_k.jpg","news_site":"Teslarati","summary":"Rocket Lab is preparing for back-to-back missions for NASA, which will see them launch twice within three weeks from Launch Complex 1...","published_at":"2024-05-01T16:43:33Z","updated_at":"2024-05-01T16:43:38.005221Z","featured":false,"launches":[],"events":[]},{"id":23378,"title":"Europe’s ambitious satellite Internet project appears to be running into trouble","url":"https://arstechnica.com/space/2024/05/europes-ambitious-satellite-internet-project-appears-to-be-running-into-trouble/","image_url":"https://cdn.arstechnica.net/wp-content/uploads/2023/05/GettyImages-1248376827.jpg","news_site":"Arstechnica","summary":"The devil, as always, is in the details.","published_at":"2024-05-01T14:43:59Z","updated_at":"2024-05-01T14:53:24.481226Z","featured":false,"launches":[],"events":[]},{"id":23377,"title":"Nurturing U.K. expertise: a strategic imperative in the emerging space era","url":"https://spacenews.com/nurturing-uk-expertise-strategic-imperative-emerging-space-era/","image_url":"https://i0.wp.com/spacenews.com/wp-content/uploads/2024/05/A_rare_cloud-free_view_of_Ireland_Great_Britain_and_northern_France_ESA285511-scaled.jpg","news_site":"SpaceNews","summary":"The U.K. government must embrace academia, capitalize on private investment in the sector and continue to foster partnerships among the three — and seek opportunities to strengthen them in areas where they are weak.","published_at":"2024-05-01T14:30:00Z","updated_at":"2024-05-01T14:33:08.848673Z","featured":false,"launches":[],"events":[]},{"id":23376,"title":"Daily Telescope: The Horsehead Nebula as we’ve never seen it before","url":"https://arstechnica.com/space/2024/05/daily-telescope-seeing-a-mane-attraction-up-close/","image_url":"https://cdn.arstechnica.net/wp-content/uploads/2024/04/weic2411a.jpg","news_site":"Arstechnica","summary":"Webb delivers with a new look on an iconic classic.","published_at":"2024-05-01T12:00:25Z","updated_at":"2024-05-01T12:13:27.293590Z","featured":false,"launches":[],"events":[]}]
        """
    }
}

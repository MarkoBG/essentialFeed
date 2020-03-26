//
//  LocalFeedItem.swift
//  EssentialFeed
//
//  Created by Marko Tribl on 3/23/20.
//  Copyright © 2020 Marko Tribl. All rights reserved.
//

import Foundation

public struct LocalFeedItem: Equatable, Codable {
    public let id: UUID
    public let description: String?
    public let location: String?
    public let imageURL: URL
    
    public init(id: UUID, description: String?, location: String?, imageURL: URL) {
        self.id = id
        self.description = description
        self.location = location
        self.imageURL = imageURL
    }
}

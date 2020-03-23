//
//  RemoteFeedItem.swift
//  EssentialFeed
//
//  Created by Marko Tribl on 3/23/20.
//  Copyright © 2020 Marko Tribl. All rights reserved.
//

import Foundation

internal struct RemoteFeedItem: Decodable {
    internal let id: UUID
    internal let description: String?
    internal let location: String?
    internal let image: URL
}

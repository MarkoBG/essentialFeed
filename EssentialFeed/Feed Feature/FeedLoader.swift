//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Marko Tribl on 9/28/19.
//  Copyright © 2019 Marko Tribl. All rights reserved.
//

import Foundation

public protocol FeedLoader {
    typealias Result = Swift.Result<[FeedItem], Error>
    func load(completion: @escaping (Result) -> Void)
}

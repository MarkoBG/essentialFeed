//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Marko Tribl on 9/28/19.
//  Copyright © 2019 Marko Tribl. All rights reserved.
//

import Foundation

public enum LoadFeedResult<Error: Swift.Error> {
    case success([FeedItem])
    case failure(Error)
}

extension LoadFeedResult: Equatable where Error: Equatable {}

protocol FeedLoader {
    associatedtype Error: Swift.Error
    func load(completion: @escaping (LoadFeedResult<Error>) -> Void)
}

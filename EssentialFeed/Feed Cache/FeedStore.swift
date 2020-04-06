//
//  FeedStore.swift
//  EssentialFeed
//
//  Created by Marko Tribl on 3/11/20.
//  Copyright © 2020 Marko Tribl. All rights reserved.
//

import Foundation

public enum CacheFeed {
    case empty
    case found(feed: [LocalFeedItem], timestamp: Date)
}

public protocol FeedStore {
    typealias DeletionCompletion = (Error?) -> Void
    typealias InsertionCompletion = (Error?) -> Void
    
    typealias RetreivalResult = Result<CacheFeed, Error>
    typealias RetrievalCompletion = (RetreivalResult) -> Void
    
    /// The completion handler can be invoked in any thread.
    /// Clients are responsible to dispatch to appropriate threads, if needed.
    func deleteCacheFeed(completion: @escaping DeletionCompletion)
    
    /// The completion handler can be invoked in any thread.
    /// Clients are responsible to dispatch to appropriate threads, if needed.
    func insert(_ items: [LocalFeedItem], timestamp: Date, completion: @escaping InsertionCompletion)
    
    /// The completion handler can be invoked in any thread.
    /// Clients are responsible to dispatch to appropriate threads, if needed.
    func retrieve(completion: @escaping RetrievalCompletion)
}

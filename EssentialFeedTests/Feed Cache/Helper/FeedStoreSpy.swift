//
//  FeedStoreSpy.swift
//  EssentialFeedTests
//
//  Created by Marko Tribl on 3/24/20.
//  Copyright © 2020 Marko Tribl. All rights reserved.
//

import Foundation
import EssentialFeed

class FeedStoreSpy: FeedStore {

    enum ReceivedMessage: Equatable {
        case deleteCachedFeed
        case insert([LocalFeedItem], Date)
        case retrieve
    }
    
    private(set) var receivedMessages = [ReceivedMessage]()
    
    private var deletionCompletions = [DeletionCompletion]()
    private var insertionCompletions = [InsertionCompletion]()
    private var retrievalCompletions = [RetrievalCompletion]()
    
    func deleteCacheFeed(completion: @escaping DeletionCompletion) {
        deletionCompletions.append(completion)
        receivedMessages.append(.deleteCachedFeed)
    }
    
    func completeDeletion(with error: Error, at index: Int = 0) {
        deletionCompletions[index](error)
    }
    
    func completeDeletionSuccessfully(at index: Int = 0) {
        deletionCompletions[index](nil)
    }
    
    func insert(_ items: [LocalFeedItem], timestamp: Date, completion: @escaping InsertionCompletion) {
        insertionCompletions.append(completion)
        receivedMessages.append(.insert(items, timestamp))
    }
    
    func completeInsertion(with error: Error, at index: Int = 0) {
        insertionCompletions[index](error)
    }
    
    func completeInsertionSuccessfully(at index: Int = 0) {
        insertionCompletions[index](nil)
    }
    
    func retrieve(completion: @escaping RetrievalCompletion) {
        retrievalCompletions.append(completion)
        receivedMessages.append(.retrieve)
    }
    
    func completeRetrieval(with error: Error, at index: Int = 0) {
        retrievalCompletions[index](.failure(error))
    }
    
    func completeRetrievalWitchEmptyCache(at index: Int = 0) {
        retrievalCompletions[index](.success(.empty))
    }
    
    func completeRetrieval(with feed: [LocalFeedItem], timestamp: Date, at index: Int = 0) {
        retrievalCompletions[index](.success(.found(feed: feed, timestamp: timestamp)))
    }
}

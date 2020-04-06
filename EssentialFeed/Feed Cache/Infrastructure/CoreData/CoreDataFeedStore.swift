//
//  CoreDataFeedStore.swift
//  FeedStoreChallenge
//
//  Created by Marko Tribl on 4/5/20.
//  Copyright © 2020 Essential Developer. All rights reserved.
//

import Foundation
import CoreData

public final class CoreDataFeedStore: FeedStore {
    
    private let persistentContainer: NSPersistentContainer
    private let context: NSManagedObjectContext
    
    public init(storeURL: URL, bundle: Bundle = .main) throws {
        persistentContainer = try NSPersistentContainer.load(modelName: "CoreDataFeedStore", url: storeURL, in: bundle)
        context = persistentContainer.newBackgroundContext()
    }
    
    public func deleteCacheFeed(completion: @escaping DeletionCompletion) {
        let context = self.context
        context.perform {
            do {
                try ManagedCache.find(in: context).map(context.delete).map(context.save)
                completion(nil)
            } catch {
                completion(error)
            }
        }
    }
    
    public func insert(_ feed: [LocalFeedItem], timestamp: Date, completion: @escaping InsertionCompletion) {
        let context = self.context
        context.perform {
            do {
                let cache = try ManagedCache.newUniqueInstance(in: context)
                cache.timestamp = timestamp
                
                let images = ManagedFeedImage.images(from: feed, in: context)
                
                cache.feed = images
                
                try context.save()
                completion(nil)
                
            } catch {
                completion(error)
            }
        }
    }
    
    public func retrieve(completion: @escaping RetrievalCompletion) {
        let context = self.context
        
        context.perform {
            do {
                if let cache = try ManagedCache.find(in: context) {
                    completion(.success(.found(feed: cache.localFeed, timestamp: cache.timestamp)))
                } else {
                    completion(.success(.empty))
                }
            } catch {
                completion(.failure(error))
            }
        }
    }
}



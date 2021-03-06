//
//  FeedCacheTestHelpers.swift
//  EssentialFeedTests
//
//  Created by Marko Tribl on 3/25/20.
//  Copyright © 2020 Marko Tribl. All rights reserved.
//

import Foundation
import EssentialFeed


func uniqueItem() -> FeedItem {
    return FeedItem(id: UUID(), description: "any", location: "any", imageURL: anyURL())
}
    
func uniqueItems() -> (models: [FeedItem], local: [LocalFeedItem]) {
    let items = [uniqueItem(), uniqueItem()]
    let localItems = items.map { LocalFeedItem(id: $0.id, description: $0.description, location: $0.location, imageURL: $0.imageURL) }
    return (items, localItems)
}


extension Date {
    
    private var feedCacheMaxAgeInDays: Int {
        return 7
    }
    
    func minusFeedCacheMaxAge() -> Date {
        return adding(days: -feedCacheMaxAgeInDays)
    }
    
    private func adding(days: Int) -> Date {
        return Calendar(identifier: .gregorian).date(byAdding: .day, value: days, to: self)!
    }
}

extension Date {
    func adding(seconds: TimeInterval) -> Date {
        return self + seconds
    }
}

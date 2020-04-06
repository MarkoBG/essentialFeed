//
//  ManagedFeedImage.swift
//  FeedStoreChallenge
//
//  Created by Marko Tribl on 4/5/20.
//  Copyright © 2020 Essential Developer. All rights reserved.
//

import Foundation
import CoreData

@objc(ManagedFeedImage)
internal class ManagedFeedImage: NSManagedObject {
    @NSManaged internal var id: UUID
    @NSManaged internal var imageDescription: String?
    @NSManaged internal var location: String?
    @NSManaged internal var url: URL
    @NSManaged internal var cache: ManagedCache
    
    internal var local: LocalFeedItem {
        return LocalFeedItem(id: id, description: imageDescription, location: location, imageURL: url)
    }
    
    internal static func images(from localFeed: [LocalFeedItem], in context: NSManagedObjectContext) -> NSOrderedSet {
        return NSOrderedSet(array: localFeed.map { local in
            let image = ManagedFeedImage(context: context)
            image.id = local.id
            image.imageDescription = local.description
            image.location = local.location
            image.url = local.imageURL
            return image
        })
    }
}

//
//  SharedTestHelpers.swift
//  EssentialFeedTests
//
//  Created by Marko Tribl on 3/25/20.
//  Copyright © 2020 Marko Tribl. All rights reserved.
//

import Foundation

func anyNSError() -> NSError {
    return NSError(domain: "Any error", code: 0)
}

func anyURL() -> URL {
    return URL(string: "http://any-url.com")!
}

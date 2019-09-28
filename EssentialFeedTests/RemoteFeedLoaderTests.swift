//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Marko Tribl on 9/28/19.
//  Copyright © 2019 Marko Tribl. All rights reserved.
//

import XCTest

class RemoteFeedLoader {
    
    let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func load() {
        client.get(from: URL(string: "https://a-url.com")!)
    }
}

protocol HTTPClient {
    func get(from url: URL)
}

// we are using HTTPClientSpy class for testing purposes, becouse we don't want to have requestedURL in prodaction code
class HTTPClientSpy: HTTPClient {
    
    var requestedURL: URL?
    
    func get(from url: URL) {
        requestedURL = url
    }
}



class RemoteFeedLoaderTest: XCTestCase {
    
    func test_init_doseNotRequestDataFromURL() {
        let client = HTTPClientSpy()
        _ = RemoteFeedLoader(client: client)
        
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestDataFromURL() {
        
        // Arrange
        // Given a client and a sut
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(client: client)

        // Act
        // When we invoke sut.load()
        sut.load()
        
        // Assert
        // Then assert that a URL request was initiated in the client
        XCTAssertNotNil(client.requestedURL)
    }
}



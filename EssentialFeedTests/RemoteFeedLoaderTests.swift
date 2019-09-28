//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Marko Tribl on 9/28/19.
//  Copyright © 2019 Marko Tribl. All rights reserved.
//

import XCTest
import EssentialFeed

class RemoteFeedLoaderTest: XCTestCase {
    
    func test_init_doseNotRequestDataFromURL() {
        let (_, client) = makeSUT()
        
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestDataFromURL() {
        
        // Arrange
        // Given a client and a sut
        let url = URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)

        // Act
        // When we invoke sut.load()
        sut.load()
        
        // Assert
        // Then assert that a URL request was initiated in the client
        XCTAssertNotNil(client.requestedURL)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(url: URL = URL(string: "https://a-url.com")!) -> (sut: RemoteFeedLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        return (sut, client)
    }
    
    private class HTTPClientSpy: HTTPClient {
        
        var requestedURL: URL?
        
        func get(from url: URL) {
            requestedURL = url
        }
    }
}



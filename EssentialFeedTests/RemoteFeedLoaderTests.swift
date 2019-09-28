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
        
        XCTAssertTrue(client.requestedURLs.isEmpty)
    }
    
    func test_load_requestsDataFromURL() {
        
        // Arrange
        // Given a client and a sut
        let url = URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)

        // Act
        // When we invoke sut.load()
        sut.load()
        
        // Assert
        // Then assert that a URL request was initiated in the client
        XCTAssertEqual(client.requestedURLs, [url])
    }
    
    func test_loadTwice_requestsDataFromURLTwice() {
        
        let url = URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)

        sut.load()
        sut.load()
        
        XCTAssertEqual(client.requestedURLs, [url, url])
    }
    
    func test_load_deliversErrorOnClientError() {
        let (sut, client) = makeSUT()
        var capturedErrors = [RemoteFeedLoader.Error]()
        sut.load { capturedErrors.append($0) }
        
        let clientError = NSError(domain: "Test", code: 0)
        client.completions[0](clientError)
        
        XCTAssertEqual(capturedErrors, [.connectivity])
        
    }
    
    // MARK: - Helpers
    
    private func makeSUT(url: URL = URL(string: "https://a-url.com")!) -> (sut: RemoteFeedLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        return (sut, client)
    }
    
    private class HTTPClientSpy: HTTPClient {

        var requestedURLs = [URL]()
        var error: Error?
        var completions: [(Error) -> Void] = []
        
        func get(from url: URL, completion: @escaping (Error) -> Void) {
            completions.append(completion)
            requestedURLs.append(url)
        }
    }
}



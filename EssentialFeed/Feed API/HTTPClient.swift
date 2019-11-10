//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by Marko Tribl on 11/10/19.
//  Copyright © 2019 Marko Tribl. All rights reserved.
//

import Foundation

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}

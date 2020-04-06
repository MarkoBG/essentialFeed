//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by Marko Tribl on 11/10/19.
//  Copyright © 2019 Marko Tribl. All rights reserved.
//

import Foundation

public protocol HTTPClient {
    
    typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>
    
    /// The completion handler can be invoked in any thread.
    /// Clients are responsible to dispatch to appropriate threads, if needed.
    func get(from url: URL, completion: @escaping (Result) -> Void)
}

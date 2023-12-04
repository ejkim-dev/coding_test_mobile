//
//  NetworkSessionManager.swift
//  coding_test_mobile
//
//  Created by eunjin kim on 12/3/23.
//

import Foundation

protocol NetworkSessionManager {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    
    func request(_ request: URLRequest, completion: @escaping CompletionHandler)
}

final class DefaultNetworkSessionManager: NetworkSessionManager {
    func request(_ request: URLRequest, completion: @escaping CompletionHandler) {
        let task = URLSession(configuration: .default).dataTask(with: request, completionHandler: completion)
        task.resume()
    }
}

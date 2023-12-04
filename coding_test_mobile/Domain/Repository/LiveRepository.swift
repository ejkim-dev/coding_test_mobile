//
//  LiveRepository.swift
//  coding_test_mobile
//
//  Created by eunjin kim on 12/4/23.
//

import Foundation

protocol LiveRepository {
    typealias CompletionHandler = (Result<Live, ErrorResult>) -> Void
    
    func fetchLive(accessKey: String, completion: @escaping CompletionHandler)
}

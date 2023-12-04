//
//  LiveUseCase.swift
//  coding_test_mobile
//
//  Created by eunjin kim on 12/4/23.
//

import Foundation

protocol LiveUseCase {
    typealias CompletionHandler = (Result<Live, ErrorResult>) -> Void
    
    func fetchLive(completion: @escaping CompletionHandler)
}

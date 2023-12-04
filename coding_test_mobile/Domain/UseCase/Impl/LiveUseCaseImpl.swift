//
//  LiveUseCaseImpl.swift
//  coding_test_mobile
//
//  Created by eunjin kim on 12/4/23.
//

import Foundation

class LiveUseCaseImpl: LiveUseCase {
    private let liveRepository: LiveRepository
    init(liveRepository: LiveRepository) {
        self.liveRepository = liveRepository
    }
    
    func fetchLive(accessKey: String, completion: @escaping CompletionHandler) {
        liveRepository.fetchLive(accessKey: accessKey) { result in
            completion(result)
        }
    }
}

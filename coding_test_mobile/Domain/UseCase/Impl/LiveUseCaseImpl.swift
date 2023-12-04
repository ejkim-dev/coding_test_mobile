//
//  LiveUseCaseImpl.swift
//  coding_test_mobile
//
//  Created by eunjin kim on 12/4/23.
//

import Foundation

class LiveUseCaseImpl: LiveUseCase {
    private let liveRepository: LiveRepository
    private lazy var appConfiguration = AppConfiguration()
    
    init(liveRepository: LiveRepository) {
        self.liveRepository = liveRepository
    }
    
    func fetchLive(completion: @escaping CompletionHandler) {
        liveRepository.fetchLive(accessKey: appConfiguration.apiKey) { result in
            completion(result)
        }
    }
}

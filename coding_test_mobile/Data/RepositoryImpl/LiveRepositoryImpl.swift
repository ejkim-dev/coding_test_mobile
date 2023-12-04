//
//  LiveRepositoryImpl.swift
//  coding_test_mobile
//
//  Created by eunjin kim on 12/4/23.
//

import Foundation

class LiveRepositoryImpl: LiveRepository {

    func fetchLive(accessKey: String, completion: @escaping CompletionHandler) {
        ApiService.shared.getLive(param: ["access_key": accessKey]) { apiResult in
            switch apiResult {
            case .success(let data):
                guard let convertData: Live = DataConvertor.convertDictionaryToCodable(dict: data) else {
                    completion(.failure(.parseError))
                    return
                }
                    
                completion(.success(convertData))

            case .failure(let error):
                let errorResult: ErrorResult
                switch error {
                case .error(message: let message):
                    errorResult = .error(message: message)
                case .httpError(statusCode: let code, message: let message):
                    errorResult = .error(message: "http error: \(code) | \(message)")
                case .notConnected:
                    errorResult = .error(message: "인터넷 연결을 확인하세요")
                case .parseError:
                    errorResult = .parseError
                case .unauthorized(message: let message):
                    errorResult = .unauthorized(message: message)
                }
                completion(.failure(errorResult))
            }
        }
    }
}

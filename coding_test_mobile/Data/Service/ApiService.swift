//
//  ApiService.swift
//  coding_test_mobile
//
//  Created by eunjin kim on 12/3/23.
//

import Foundation

class ApiService {
    static let shared = ApiService()
    
    typealias CompletionHandler<T> = (Result<T, ErrorResultEntity>) -> Void
    private let httpService: HttpService
    
    private init() {
        self.httpService = HttpService(baseUrl: AppConfiguration.BASE_URL)
    }
    
    func getLive (
        param: [String : Any],
        completion: @escaping CompletionHandler<[String:Any]>) {
        return self.httpService.request(path: "api/live", method: .get, queryParameters: param) { result in
            completion(result)
        }
    }
}

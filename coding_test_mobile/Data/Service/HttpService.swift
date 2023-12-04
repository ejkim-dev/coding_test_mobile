//
//  HttpDataSource.swift
//  coding_test_mobile
//
//  Created by eunjin kim on 12/3/23.
//

import Foundation

class HttpService {
    typealias CompletionHandler = (Result<[String: Any], ErrorResultEntity>) -> Void
    private let baseUrl: String
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl.last != "/" ? baseUrl + "/" : baseUrl
    }
    
    func request(path: String, method: HTTPMethodType, queryParameters immutableQueryParameters: [String : Any]? = nil, completion: @escaping CompletionHandler) {
        do {
            let urlRequest = try getRequestUrl(path: path, method: method, queryParameters: immutableQueryParameters)
            return request(request: urlRequest, completion: completion)
        } catch {
            return
        }
    }
    
    private func request(request: URLRequest, completion: @escaping CompletionHandler) {
        DefaultNetworkSessionManager().request(request) { data, response, error in
            if let error {
                completion(.failure(self.resolve(error: error)))
            }
            
            if let data {
                let successsRange = 200..<300
                if let statusCode = (response as? HTTPURLResponse)?.statusCode,
                      successsRange.contains(statusCode) {
                    let strData = String(decoding: data, as: UTF8.self)
                    completion(self.checkData(data: Data(strData.utf8)))
                } else {
                    completion(.failure(.httpError(statusCode: (response as? HTTPURLResponse)?.statusCode ?? 0, message: (response as? HTTPURLResponse)?.description ?? "")))
                }
            }
        }
    }
    
    private func checkData(data: Data) -> Result<[String: Any], ErrorResultEntity> {
        guard let result = DataConvertor.convertDataToDictionary(data: data) else { return .failure(.parseError) }
        guard let isSuccess = result["success"] as? Bool else { return .failure(.parseError) }
        
        if isSuccess { return .success(result) }
        
        guard let errorData: ErrorResponse = DataConvertor.convertDictionaryToCodable(dict: result) else { return .failure(.parseError) }
        
        let currentError = errorData.error
        if currentError.code == 101 {
            return .failure(.unauthorized(message: "\(currentError.type!) | \(currentError.info)"))
        }
        
        return .failure(.httpError(statusCode: currentError.code, message: currentError.info))
    }
    
    private func getRequestUrl(path: String, method: HTTPMethodType, queryParameters immutableQueryParameters: [String : Any]?) throws -> URLRequest {
        var queryString = ""
        if let queryParameters = immutableQueryParameters, !queryParameters.isEmpty {
            queryString = queryParameters.map { (key: String, value: Any) -> String in
                    if let valueArray = value as? [Any] {
                        return valueArray.map { "\(key)=\($0)" }.joined(separator: "&")
                    } else {
                        return "\(key)=\(value)"
                    }
                }
                .joined(separator: "&")
        }
        
        var url = self.baseUrl + path
        if queryString != "" { url += "?" + queryString }
        
        var urlRequest = URLRequest(url: URL(string: url)!)
        urlRequest.httpMethod = method.rawValue
        
        return urlRequest
    }
    
    private func resolve(error: Error) -> ErrorResultEntity {
        let code = URLError.Code(rawValue: (error as NSError).code)
        switch code {
        case .notConnectedToInternet: return .notConnected
        default: return .httpError(statusCode: code.rawValue, message: error.localizedDescription)
        }
    }
    
}

public enum HTTPMethodType: String {
    case get = "GET"
}


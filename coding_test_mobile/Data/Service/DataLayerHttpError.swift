//
//  DataLayerHttpError.swift
//  coding_test_mobile
//
//  Created by eunjin kim on 12/3/23.
//

import Foundation

struct DataLayerHttpError: Error {
    let statusCode: Int
    let message: String?
    
    init(statusCode: Int, message: String?) {
        self.statusCode = statusCode
        self.message = message
    }
    
    init?(response: HTTPURLResponse) {
        response
        guard let statusCode = response.statusCode,
              let data = response.data,
              let dataString = String(data: data, encoding: String.Encoding.utf8) else { return nil }
        self.statusCode = statusCode
        self.message = "HTTP ERROR - statusCode: \(statusCode) | errorBody: \(dataString)"
    }
    
    static func log() {
        
    }
}

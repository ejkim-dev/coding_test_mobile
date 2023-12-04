//
//  ErrorResultEntity.swift
//  coding_test_mobile
//
//  Created by eunjin kim on 12/4/23.
//

import Foundation

enum ErrorResultEntity: Error {
    case error(message: String)
    case httpError(statusCode: Int, message: String)
    case unauthorized(message: String)
    case parseError
    case notConnected
}

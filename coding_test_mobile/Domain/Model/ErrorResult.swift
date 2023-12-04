//
//  ErrorResult.swift
//  coding_test_mobile
//
//  Created by eunjin kim on 12/4/23.
//

import Foundation

enum ErrorResult: Error {
    case error(message: String)
    case unauthorized(message: String)
    case parseError
}

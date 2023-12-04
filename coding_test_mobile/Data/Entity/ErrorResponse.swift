//
//  ErrorResponse.swift
//  coding_test_mobile
//
//  Created by eunjin kim on 12/4/23.
//

import Foundation

struct ErrorResponse: Codable {
    let success: Bool
    let error: ErrorData

    struct ErrorData: Codable {
        let code: Int
        let type: String?
        let info: String
    }
}

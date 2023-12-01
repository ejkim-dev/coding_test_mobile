//
//  Currencies.swift
//  coding_test_mobile
//
//  Created by eunjin kim on 2023/11/29.
//

import Foundation

enum Currency: String, CaseIterable {
    case krw = "한국(KRW)"
    case jpy = "일본(JPY)"
    case php = "필리핀(PHP)"

    static var values: [String] {
        return Currency.allCases.map { "\($0.rawValue)" }
    }
}

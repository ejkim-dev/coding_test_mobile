//
//  Currencies.swift
//  coding_test_mobile
//
//  Created by eunjin kim on 2023/11/29.
//

import Foundation

enum Currency: String, CaseIterable {
    case krw = "KRW"
    case jpy = "JPY"
    case php = "PHP"
    
    private var name: String {
        switch self {
        case .krw: 
            return "krw".localized
        case .jpy:
            return "jpy".localized
        case .php:
            return "php".localized
        }
    }

    static var nameValues: [String] {
        return Currency.allCases.map { "\($0.name)(\($0.rawValue))" }
    }
    
    static var values: [String] {
        return Currency.allCases.map { "\($0.rawValue)" }
    }
}

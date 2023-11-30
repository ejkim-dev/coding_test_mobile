//
//  Currencies.swift
//  coding_test_mobile
//
//  Created by eunjin kim on 2023/11/29.
//

import Foundation

enum Currency: CaseIterable {
    case krw(String)
    case jpy(String)
    case php(String)
    
    static var allCases: [Currency] {
        return [.krw("한국(KRW)"), .jpy("일본(JPY)"), .php("필리핀(PHP)")]
    }
}

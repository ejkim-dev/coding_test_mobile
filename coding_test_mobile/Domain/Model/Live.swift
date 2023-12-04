//
//  Live.swift
//  coding_test_mobile
//
//  Created by eunjin kim on 12/1/23.
//

import Foundation

struct Live: Decodable {
    let terms: String
    let privacy: String
    let timestamp: TimeInterval
    let source: String
    let quotes: [String: Double]
}

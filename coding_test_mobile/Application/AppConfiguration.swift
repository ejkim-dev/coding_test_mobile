//
//  AppConfiguration.swift
//  coding_test_mobile
//
//  Created by eunjin kim on 12/3/23.
//

import Foundation

final class AppConfiguration {
    static let BASE_URL = "http://www.apilayer.net"
    
    lazy var apiKey: String = {
        if let infoDict = Bundle.main.infoDictionary,
           let accessKey = infoDict["APILAYER_ACCESS_KEY"] as? String {
            return accessKey.removeQuotes
        } else {
            fatalError("Access key not found.")
        }
    }()
}

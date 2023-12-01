//
//  Extension.swift
//  coding_test_mobile
//
//  Created by eunjin kim on 12/1/23.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }

}

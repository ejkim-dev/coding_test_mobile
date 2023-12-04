//
//  NumberFormatUtil.swift
//  coding_test_mobile
//
//  Created by eunjin kim on 12/4/23.
//

import Foundation

final class NumberFormatUtil {
    static func convertNumberToFormatText(number: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        
        return numberFormatter.string(from: NSNumber(value: number))!
    }
}

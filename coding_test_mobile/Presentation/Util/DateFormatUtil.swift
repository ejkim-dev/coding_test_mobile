//
//  DateFormatUtil.swift
//  coding_test_mobile
//
//  Created by eunjin kim on 12/5/23.
//

import Foundation

final class DateFormatUtil {
    static func getTodayDateTime(timestamp: TimeInterval?) -> String {
        let dateFormatter = DateFormatter()
        let date: Date
        if let timestamp {
            date = NSDate(timeIntervalSince1970: timestamp) as Date
        } else {
            date = Date()
            dateFormatter.timeZone = TimeZone.current
        }
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        return dateFormatter.string(from: date)
    }
}

//
//  Date+Extension.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 5.12.23.
//

import Foundation

enum DateFormat: String {
    case dayOfMonth = "EEE"
    case dayOfWeek = "dd"
}

extension Date {
    var todayDateInCalendar: Bool {
        let calendar = Calendar.current
        return calendar.isDate(Date(), inSameDayAs: self)
    }

    var getWeekOfDayName: String {
        return formatted(.dayOfMonth)
    }

    var getDayOfWeekNumber: String {
        return formatted(.dayOfWeek)
    }

    func formatted(_ format: DateFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: self)
    }
}

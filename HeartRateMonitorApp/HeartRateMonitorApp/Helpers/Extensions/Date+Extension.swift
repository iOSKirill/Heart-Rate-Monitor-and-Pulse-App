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
    case dateOfHistory = "dd.MM.yyyy - HH:mm"
    case dateOfHistoryDetails = "HH:mm"
    case dateOfLowHealthRange = "dd.MM.yyyy"
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

    var getDateOfHistory: String {
        return formatted(.dateOfHistory)
    }

    var getDateStatistics: String {
        return formatted(.dateOfHistoryDetails)
    }

    var getDateOfHistoryDetails: String {
        let calendar = Calendar.current
        if calendar.isDateInToday(self) {
            return "\(L10n.HistoryInfo.Time.today) \(formatted(.dateOfHistoryDetails))"
        } else if calendar.isDateInYesterday(self) {
            return "\(L10n.HistoryInfo.Time.yesterday) \(formatted(.dateOfHistoryDetails))"
        } else {
            return formatted(.dateOfHistory)
        }
    }

    var getDateHomeDeatails: String {
        let calendar = Calendar.current
        if calendar.isDateInToday(self) {
            return "\(L10n.HistoryInfo.Time.today) \(formatted(.dateOfHistoryDetails))"
        } else {
            return "\(L10n.Dashboard.Headline.title)"
        }
    }

    var getDateOfHistoryLowHealthRange: String {
        let calendar = Calendar.current
        if calendar.isDateInToday(self) {
            return L10n.HistoryInfo.Subtitle.HighHealthRange.today
        } else {
            return "\(L10n.HistoryInfo.Subtitle.HighHealthRange.otherDates) \(formatted(.dateOfLowHealthRange))!"
        }
    }

    private func formatted(_ format: DateFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: self)
    }
}

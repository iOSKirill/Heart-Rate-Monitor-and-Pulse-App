//
//  Date+Extension.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 5.12.23.
//

import Foundation

extension Date {
    /// "EEE"
    func weekDayAbbrev() -> String {
        return self.formatted(.dateTime .weekday(.abbreviated))
    }
    /// "dd"
    func dayNum() -> String {
        return self.formatted(.dateTime .day())
    }
}

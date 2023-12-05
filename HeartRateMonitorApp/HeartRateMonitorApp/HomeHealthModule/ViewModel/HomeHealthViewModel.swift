//
//  HomeHealthViewModel.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 29.11.23.
//

import Foundation

final class HomeHealthViewModel: ObservableObject {
    // MARK: - Property -
    @Published var settingsVM = SettingsViewModel()
    @Published var currentWeek: [Date] = []
    @Published var currentDay: Date = Date()
    let calendar = Calendar.current
    
    // MARK: - Intializing -
    init() {
        fetchCurrentWeek()
    }
    
    func fetchCurrentWeek() {
        let today = Date()
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
        guard let firstWeekDay = week?.start else { return }
        (0...7).forEach { day in
            if let weekDay = calendar.date(byAdding: .day, value: day, to: firstWeekDay) {
                currentWeek.append(weekDay)
            }
        }
    }
    
    // MARK: - Checking if currnet Date is Today -
    func isToday(date: Date) -> Bool {
        calendar.isDate(currentDay, inSameDayAs: date)
    }
}

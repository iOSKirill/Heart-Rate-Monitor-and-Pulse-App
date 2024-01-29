//
//  HomeHealthViewModel.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 29.11.23.
//

import Foundation
import SwiftUI

final class HomeHealthViewModel: ObservableObject {
    // MARK: - Property -
    @Published private(set) var settingsVM = SettingsViewModel()
    @Published private(set) var currentWeek: [Date] = []
    @Published private(set) var currentDay = Date()
    @Published var isScroll = false
    @Published var isPresentedMeasurementView = false
    @Published var isPresentedSettingsView = false
    @Published var scrollOffSet: CGFloat = 0.0
    private let calendar = Calendar.current

    // MARK: - Intializing -
    init() {
        fetchCurrentWeek()
    }

    // MARK: - Fetch days current week -
    func fetchCurrentWeek() {
        let today = Date()
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
        guard let firstWeekDay = week?.start else { return }
        currentWeek = (0...6).compactMap { day in
            calendar.date(byAdding: .day, value: day, to: firstWeekDay)
        }
    }
}

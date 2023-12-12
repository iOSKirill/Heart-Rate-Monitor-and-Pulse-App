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
    @Published var isPopupVisible = false
    @Published var isScroll = false
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

    // MARK: - Reading the scroll offset -
    func getScrollOffsetReader() -> some View {
        GeometryReader { proxy in
            Color.clear.preference(key: ScrollPreKey.self, value: proxy.frame(in: .named("scroll")).minY)
        }
    }

    // MARK: - Update scroll status  -
    func updateSrollStatus(value: CGFloat) {
        isScroll = value < 30
    }
}

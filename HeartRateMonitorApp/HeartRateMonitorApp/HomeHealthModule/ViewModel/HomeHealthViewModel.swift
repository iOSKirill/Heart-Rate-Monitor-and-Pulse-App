//
//  HomeHealthViewModel.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 29.11.23.
//

import Foundation
import RealmSwift
import SwiftUI

final class HomeHealthViewModel: ObservableObject {
    // MARK: - Property -
    @Published private(set) var settingsVM = SettingsViewModel()
    @Published private(set) var currentWeek: [Date] = []
    @Published private(set) var currentDay = Date()
    @Published var dailyAverage: DailyAverage
    @Published var isScroll = false
    @Published var isPresentedMeasurementView = false
    @Published var scrollOffSet: CGFloat = 0.0
    @Published var pulseData: [PulseData] = []
    @Published var isOnToggleTodayAndWeek: Bool = true {
        didSet {
            trackingChangesRealmDB()
        }
    }
    private let calendar = Calendar.current

    var realmManager: RealmManagerProtocol = RealmManager()
    private var notificationToken: NotificationToken?

    private(set) var blueGradient = Gradient(colors: [
        .appBlueGradientFirstButton,
        .appBlueGradientSecondButton
    ])

    // MARK: - Intializing -
    init(dailyAverage: DailyAverage) {
        self.dailyAverage = realmManager.getDailyAverage(date: .now)
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

    // Observer Realm
    func trackingChangesRealmDB() {
        guard let results = realmManager.realm?.objects(PulseDB.self) else { return }
        notificationToken = results.observe { [weak self] (changes: RealmCollectionChange) in
            switch changes {
            case .initial:
                if self?.isOnToggleTodayAndWeek == true {
                    self?.pulseData = self?.realmManager.getPulseDataForCurrentDay() ?? []
                } else {
                    self?.pulseData = self?.realmManager.getAveragePulseForWeek() ?? []
                }
            case .update:
                if self?.isOnToggleTodayAndWeek == true {
                    self?.pulseData = self?.realmManager.getPulseDataForCurrentDay() ?? []
                } else {
                    self?.pulseData = self?.realmManager.getAveragePulseForWeek() ?? []
                }
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }

    // Deinit Observer Realm
    deinit {
        guard let notificationToken = notificationToken else { return }
        notificationToken.invalidate()
    }

    func getDescriptionForAssessment() -> String {
        guard let assessment = dailyAverage.assessment else { return "" }
        switch assessment {
        case 70...100:
            return dailyAverage.time?.getDateOfHistoryLowHealthRange ?? ""

        case 40..<70:
            return L10n.HistoryInfo.Subtitle.mediumHealthRange

        case 0..<40:
            return  L10n.HistoryInfo.Subtitle.lowHealthRange

        default:
            return dailyAverage.time?.getDateOfHistoryLowHealthRange ?? ""
        }
    }

    func calculateDailyAverage(date: Date) {
        dailyAverage = realmManager.getDailyAverage(date: date)
    }
}

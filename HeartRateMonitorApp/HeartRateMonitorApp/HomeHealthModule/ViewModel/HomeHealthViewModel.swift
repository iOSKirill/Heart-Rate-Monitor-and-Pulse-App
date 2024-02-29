//
//  HomeHealthViewModel.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 29.11.23.
//

import Foundation
import RealmSwift
import SwiftUI

enum MeasurementState {
    case noData
    case defaultMeasurement
    case details
}

final class HomeHealthViewModel: ObservableObject {
    // MARK: - Property -
    @Published private(set) var settingsVM = SettingsViewModel()
    @Published private(set) var currentWeek: [Date] = []
    @Published var selectedDate: Date?
    @Published var isScroll = false
    @Published var isPresentedMeasurementView = false
    @Published var scrollOffSet: CGFloat = 0.0
    @Published var pulseData: [PulseData] = []
    @Published var measurementState: MeasurementState = .defaultMeasurement
    @Published var dailyAverage: DailyAverage {
        didSet {
            updateMeasurementState()
        }
    }
    @Published var isOnToggleTodayAndWeek: Bool = true {
        didSet {
            trackingChangesRealmDB()
        }
    }

    private var calendar = Calendar.current
    private var realmManager: RealmManagerProtocol = RealmManager()
    private var notificationToken: NotificationToken?

    private(set) var blueGradient = Gradient(colors: [
        .appBlueGradientFirstButton,
        .appBlueGradientSecondButton
    ])

    // MARK: - Intializing -
    init(dailyAverage: DailyAverage) {
        self.dailyAverage = realmManager.getDailyAverage(date: .now)
        fetchCurrentWeek()
        updateMeasurementState()
    }

    // Fetch days current week
    func fetchCurrentWeek() {
        guard let week = calendar.dateInterval(of: .weekOfMonth, for: Date()) else { return }
        currentWeek = (0...6).compactMap { calendar.date(byAdding: .day, value: $0, to: week.start) }
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

    // Changing the text depending on the assessment
    func getDescriptionForAssessment() -> String {
        switch dailyAverage.assessment {
        case 70...100:
            return dailyAverage.time.getDateOfHistoryLowHealthRange

        case 40..<70:
            return L10n.HistoryInfo.Subtitle.mediumHealthRange

        case 0..<40:
            return L10n.HistoryInfo.Subtitle.lowHealthRange

        default:
            return ""
        }
    }

    // Checks if there is a measurement for the given date
    func hasMeasurementForDay(date: Date) -> Bool {
        realmManager.hasMeasurementForDay(date: date)
    }

    // Calculates the daily average for the given date
    func calculateDailyAverage(date: Date) {
        dailyAverage = realmManager.getDailyAverage(date: date)
    }

    // Updates the measurement state based on the daily average pulse
    func updateMeasurementState() {
        let isTodayDate = isToday(date: dailyAverage.time)
         measurementState = dailyAverage.isEmpty
             ? (isTodayDate ? .defaultMeasurement : .noData)
             : .details
    }

    // Checks if the given date is today
    private func isToday(date: Date) -> Bool {
        return calendar.isDateInToday(date)
    }
}

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
    @Published var isScroll = false
    @Published var isPresentedMeasurementView = false
    @Published var scrollOffSet: CGFloat = 0.0
    @Published var pulseData: [PulseData] = []
    private let calendar = Calendar.current

    private var realmManager: RealmManagerProtocol = RealmManager()
    private var notificationToken: NotificationToken?

    private(set) var blueGradient = Gradient(colors: [
        .appBlueGradientFirstButton,
        .appBlueGradientSecondButton
    ])

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

    // Observer Realm
    func trackingChangesRealmDB() {
        guard let results = realmManager.realm?.objects(PulseDB.self) else { return }
        notificationToken = results.observe { [weak self] (changes: RealmCollectionChange) in
            switch changes {
            case .initial:
                self?.pulseData = self?.realmManager.getPulseDataForCurrentDay() ?? []
            case .update:
                self?.pulseData = self?.realmManager.getPulseDataForCurrentDay() ?? []
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
}

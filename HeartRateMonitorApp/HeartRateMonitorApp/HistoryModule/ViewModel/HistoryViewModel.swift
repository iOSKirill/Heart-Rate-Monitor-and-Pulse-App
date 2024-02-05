//
//  HistoryViewModel.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 29.11.23.
//

import Foundation
import RealmSwift
import SwiftUI

final class HistoryViewModel: ObservableObject {
    // MARK: - Property -
    @Published var isPresentedSettingsView: Bool = false
    @Published var scrollOffSet: CGFloat = 0.0
    @Published var arrayPulseDB: [PulseDB] = []

    private var realmManager: RealmManagerProtocol = RealmManager()
    private var notificationToken: NotificationToken?

    private(set) var rectangleGradientFirst = Gradient(colors: [
        .appBlueWhiteGradientFirst,
        .appBlueWhiteGradientSecond
    ])
    private(set) var rectangleGradientSecond = Gradient(colors: [
        .appWhiteGradientFirst,
        .appWhiteGradientSecond
    ])

    // Observer Realm
    func trackingChangesRealmDB() {
        guard let results = realmManager.realm?.objects(PulseDB.self) else { return }
        notificationToken = results.observe { [weak self] (changes: RealmCollectionChange) in
            switch changes {
            case .initial:
                self?.arrayPulseDB = results.sorted(by: { $0.time > $1.time })
            case .update:
                self?.arrayPulseDB = results.sorted(by: { $0.time > $1.time })
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }

    func deleteMeasurement(at indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let pulseToDelete = arrayPulseDB[index]
        realmManager.deleteMeasurementPulseDB(pulseDB: pulseToDelete)
    }

    // Deinit Observer Realm
    deinit {
        guard let notificationToken = notificationToken else { return }
        notificationToken.invalidate()
    }
}

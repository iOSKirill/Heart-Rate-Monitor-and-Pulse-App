//
//  HistoryViewModel.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 29.11.23.
//

import Foundation

final class HistoryViewModel: ObservableObject {
    // MARK: - Property -
    @Published var isPresentedSettingsView = false
    @Published var scrollOffSet: CGFloat = 0.0
}

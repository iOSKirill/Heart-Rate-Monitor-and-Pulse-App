//
//  HistoryInfoViewModel.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 8.02.24.
//

import Foundation

final class HistoryInfoViewModel: ObservableObject {
    // MARK: - Property -
    @Published var scrollOffSet: CGFloat = 0.0
    @Published var isPresentedSettingsView: Bool = false
    @Published var measurementDetails: PulseDB

    init(measurementDetails: PulseDB) {
        self.measurementDetails = measurementDetails
    }

    func getDescriptionForAssessment() -> String {
        switch measurementDetails.assessment {
        case 70...100:
            return measurementDetails.time.getDateOfHistoryLowHealthRange

        case 40..<70:
            return L10n.HistoryInfo.Subtitle.mediumHealthRange

        case 0..<40:
            return  L10n.HistoryInfo.Subtitle.lowHealthRange

        default:
            return measurementDetails.time.getDateOfHistoryLowHealthRange
        }
    }
}

//
//  DailyAverage.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 27.02.24.
//

import Foundation

struct DailyAverage {
    let pulse: Int
    let hrv: Int
    let assessment: Int
    let time: Date

    var isEmpty: Bool {
        return pulse == 0 && hrv == 0 && assessment == 0
    }
}

//
//  Filter.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 20.12.23.
//

import Foundation

private let numberOfZeros: Int = 10
private let numberOfPoles: Int = 10
private let gain: Double = 1.894427025e+01

class Filter: NSObject {
    // MARK: - Property -
    var zerosArray = [Double](repeating: 0.0, count: numberOfZeros + 1)
    var polesArray = [Double](repeating: 0.0, count: numberOfPoles + 1)

    func processValue(value: Double) -> Double {
        zerosArray[0] = zerosArray[1]
        zerosArray[1] = zerosArray[2]
        zerosArray[2] = zerosArray[3]
        zerosArray[3] = zerosArray[4]
        zerosArray[4] = zerosArray[5]
        zerosArray[5] = zerosArray[6]
        zerosArray[6] = zerosArray[7]
        zerosArray[7] = zerosArray[8]
        zerosArray[8] = zerosArray[9]
        zerosArray[9] = zerosArray[10]
        zerosArray[10] = value / gain

        polesArray[0] = polesArray[1]
        polesArray[1] = polesArray[2]
        polesArray[2] = polesArray[3]
        polesArray[3] = polesArray[4]
        polesArray[4] = polesArray[5]
        polesArray[5] = polesArray[6]
        polesArray[6] = polesArray[7]
        polesArray[7] = polesArray[8]
        polesArray[8] = polesArray[9]
        polesArray[9] = polesArray[10]

        polesArray[10] = (zerosArray[10] - zerosArray[0]) +
        5 * (zerosArray[2] - zerosArray[8]) +
        10 * (zerosArray[6] - zerosArray[4]) +
        (-0.0000000000 * polesArray[0]) + (0.0357796363 * polesArray[1]) +
        (-0.1476158522 * polesArray[2]) + (0.3992561394 * polesArray[3]) +
        (-1.1743136181 * polesArray[4]) + (2.4692165842 * polesArray[5]) +
        (-3.3820859632 * polesArray[6]) + (3.9628972812 * polesArray[7]) +
        (-4.3832594900 * polesArray[8]) + (3.2101976096 * polesArray[9])

        return polesArray[10]
    }
}

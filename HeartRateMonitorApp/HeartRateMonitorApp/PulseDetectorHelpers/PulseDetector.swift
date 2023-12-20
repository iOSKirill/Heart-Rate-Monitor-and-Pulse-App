//
//  PulseDetector.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 20.12.23.
//

import Foundation
import QuartzCore

private let maxPeriodsToStore = 20
private let averageSize = 20
private let invalidPulsePeriod = -1
private let maxPeriod = 1.5
private let minPeriod = 0.1
private let invalidEntry: Double = -100

class PulseDetector: NSObject {
    private var upVals = [Double](repeating: 0.0, count: averageSize)
    private var downVals = [Double](repeating: 0.0, count: averageSize)
    private var upValIndex = 0
    private var downValIndex = 0
    private var lastVal: Float = 0.0
    private var periods = [Double](repeating: 0.0, count: maxPeriodsToStore)
    private var periodTimes = [Double](repeating: 0.0, count: maxPeriodsToStore)
    private var periodIndex = 0
    private var started = false
    private var freq: Float = 0.0
    private var average: Float = 0.0
    private var wasDown = false
    private var periodStart: Double = 0.0

    override init() {
        super.init()
        reset()
    }

    func addNewValue(newVal: Double, atTime time: Double) -> Float {
        upVals[upValIndex] = newVal
        upValIndex = (upValIndex + 1) % averageSize

        downVals[downValIndex] = -newVal
        downValIndex = (downValIndex + 1) % averageSize

        // working out the average value above zero
        var count: Double = 0
        var total: Double = 0
        for index in 0..<averageSize where upVals[index] != invalidEntry {
            count += 1
            total += upVals[index]
        }
        let averageUp: Double = total / count

        // and the average value below zero
        count = 0
        total = 0
        for index in 0..<averageSize where downVals[index] != invalidEntry {
            count += 1
            total += downVals[index]
        }
        let averageDown: Double = total / count

        if newVal < -0.5 * averageDown {
            wasDown = true
        }
        if newVal >= 0.5 * averageUp && wasDown {
            wasDown = false
            if time - periodStart < maxPeriod && time - periodStart > minPeriod {
                periods[periodIndex] = time - periodStart
                periodTimes[periodIndex] = time
                periodIndex += 1
                if periodIndex >= maxPeriodsToStore {
                    periodIndex = 0
                }
            }
            periodStart = time
        }
        if newVal < -0.5 * averageDown {
            return -1
        } else if newVal > 0.5 * averageUp {
            return 1
        }
        return 0
    }

    func getAverage() -> Float {
        let time = CACurrentMediaTime()
        var total: Double = 0
        var count: Double = 0
        for index in 0..<maxPeriodsToStore {
            // only use upto 10 seconds worth of data
            if periods[index] != invalidEntry && time - periodTimes[index] < 10 {
                count += 1
                total += periods[index]
            }
        }
        if count > 2 {
            return Float(total / count)
        }
        return Float(invalidPulsePeriod)
    }

    func reset() {
        for index in 0..<maxPeriodsToStore {
            periods[index] = invalidEntry
        }
        for index in 0..<averageSize {
            upVals[index] = invalidEntry
            downVals[index] = invalidEntry
        }
        freq = 0.5
        periodIndex = 0
        downValIndex = 0
        upValIndex = 0
    }
}

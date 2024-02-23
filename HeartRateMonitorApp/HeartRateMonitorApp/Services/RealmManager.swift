//
//  RealmManager.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 29.01.24.
//

import Foundation
import RealmSwift

struct PulseData {
    var pulse: Int
    var time: Date
}

protocol RealmManagerProtocol {
    var realm: Realm? { get }
    func addLastMeasurement(pulse: Int, hrv: Int, assessment: Int, time: Date)
    func deleteMeasurementPulseDB(pulseDB: PulseDB)
    func getPulseDataForCurrentDay() -> [PulseData]
    func getAveragePulseForWeek() -> [PulseData]
    func hasMeasurementForDay(date: Date) -> Bool
}

final class RealmManager: RealmManagerProtocol {
    var realm = try? Realm()

    func addLastMeasurement(pulse: Int, hrv: Int, assessment: Int, time: Date) {
        let pulseDB = PulseDB(pulse: pulse, hrv: hrv, assessment: assessment, time: time)
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(pulseDB)
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    func deleteMeasurementPulseDB(pulseDB: PulseDB) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(pulseDB)
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    func getPulseDataForCurrentDay() -> [PulseData] {
        var pulseDataArray: [PulseData] = []
        do {
            let realm = try Realm()
            let startOfDay = Calendar.current.startOfDay(for: Date())
            let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)

            if let endOfDay = endOfDay {
                pulseDataArray = realm.objects(PulseDB.self)
                    .filter("time >= %@ AND time < %@", startOfDay, endOfDay)
                    .sorted(byKeyPath: "time", ascending: true)
                    .map { PulseData(pulse: $0.pulse, time: $0.time) }
            }
        } catch {
            print(error.localizedDescription)
        }
        return pulseDataArray
    }

    func getAveragePulseForWeek() -> [PulseData] {
        var averagePulse: [PulseData] = []
        do {
            let realm = try Realm()
            for index in 0..<7 {
                let startOfDay = Calendar.current.date(
                    byAdding: .day,
                    value: -index,
                    to: Calendar.current.startOfDay(for: Date())
                )
                let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay ?? Date())

                if let startOfDay = startOfDay, let endOfDay = endOfDay {
                    let pulseDataArray = realm.objects(PulseDB.self)
                        .filter("time >= %@ AND time < %@", startOfDay, endOfDay)
                        .map { PulseData(pulse: $0.pulse, time: $0.time) }

                    if !pulseDataArray.isEmpty {
                        let totalPulse = pulseDataArray.reduce(0, { $0 + $1.pulse })
                        let average = Double(totalPulse) / Double(pulseDataArray.count)

                        averagePulse.append(PulseData(pulse: Int(ceil(average)), time: startOfDay))
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        return averagePulse
    }

    func hasMeasurementForDay(date: Date) -> Bool {
        let startOfDay = Calendar.current.startOfDay(for: date)
        let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay) ?? Date()
        let pulseDataArray = realm?.objects(PulseDB.self)
            .filter("time >= %@ AND time < %@", startOfDay, endOfDay)
        return !(pulseDataArray?.isEmpty ?? true)
    }
}

class PulseDB: Object {
    @Persisted var pulse: Int
    @Persisted var hrv: Int
    @Persisted var assessment: Int
    @Persisted var time: Date

    convenience init(pulse: Int, hrv: Int, assessment: Int, time: Date) {
        self.init()
        self.pulse = pulse
        self.hrv = hrv
        self.assessment = assessment
        self.time = time
    }
}

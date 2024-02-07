//
//  RealmManager.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 29.01.24.
//

import Foundation
import RealmSwift

protocol RealmManagerProtocol {
    var realm: Realm? { get }
    func addLastMeasurement(pulseMeasurement: String, timeMeasurement: Date)
    func deleteMeasurementPulseDB(pulseDB: PulseDB)
}

final class RealmManager: RealmManagerProtocol {
    var realm = try? Realm()

    func addLastMeasurement(pulseMeasurement: String, timeMeasurement: Date) {
        let pulseDB = PulseDB(pulse: pulseMeasurement, hrv: "90", assessment: "60%", time: timeMeasurement)
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
}

class PulseDB: Object {
    @Persisted var pulse: String
    @Persisted var hrv: String
    @Persisted var assessment: String
    @Persisted var time: Date

    convenience init(pulse: String, hrv: String, assessment: String, time: Date) {
        self.init()
        self.pulse = pulse
        self.hrv = hrv
        self.assessment = assessment
        self.time = time
    }
}

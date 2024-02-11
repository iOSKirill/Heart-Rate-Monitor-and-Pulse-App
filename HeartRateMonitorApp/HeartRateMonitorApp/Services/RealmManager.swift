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
    func addLastMeasurement(pulse: Int, hrv: Int, assessment: Int, time: Date)
    func deleteMeasurementPulseDB(pulseDB: PulseDB)
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

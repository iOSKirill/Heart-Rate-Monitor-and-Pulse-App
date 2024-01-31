//
//  RealmManager.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 29.01.24.
//

import Foundation
import RealmSwift

protocol RealmManagerProtocol {
    func addLastMeasurement(valueMeasurement: String, timeMeasurement: Date)
    func deleteMeasurementPulseDB(pulseDB: PulseDB)
}

final class RealmManager: RealmManagerProtocol {
    func addLastMeasurement(valueMeasurement: String, timeMeasurement: Date) {
        let pulseDB = PulseDB(value: valueMeasurement, time: timeMeasurement)
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
    @Persisted var value: String
    @Persisted var time: Date

    convenience init(value: String, time: Date) {
        self.init()
        self.value = value
        self.time = time
    }
}

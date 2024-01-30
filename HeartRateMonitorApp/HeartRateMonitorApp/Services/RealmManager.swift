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
    func addLastMeasurement(valueMeasurement: String, timeMeasurement: Date)
    func deleteMeasurementPulseDB(pulseDB: PulseDB)
}

final class RealmManager: RealmManagerProtocol {
    var realm = try? Realm()

    func addLastMeasurement(valueMeasurement: String, timeMeasurement: Date) {
        let pulseDB = PulseDB(value: valueMeasurement, time: timeMeasurement)
        do {
            guard let realm = try? Realm() else { return }
            try realm.write {
                realm.add(pulseDB)
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    func deleteMeasurementPulseDB(pulseDB: PulseDB) {
        do {
            guard let realm = try? Realm() else { return }
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

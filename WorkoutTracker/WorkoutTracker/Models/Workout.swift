//
//  Workout.swift
//  WorkoutTracker
//
//  Created by Norman Lim on 8/5/2019.
//  Copyright © 2019 Norman Lim. All rights reserved.
//

import Foundation
import RealmSwift
import os

class Workout: Object {
    
    struct Entry: Codable {
        let exercise: Exercise
        let sets: [Set]
        
        struct Set: Codable {
            var rep: Int
            /// In kg
            var weight: Decimal
        }
    }
    
    @objc dynamic var fromDate = Date()
    @objc dynamic var toDate = Date()
    @objc dynamic var entriesJSONString = ""
    @objc dynamic var id = Int(Date().timeIntervalSince1970)
    
    var duration: TimeInterval {
        return toDate.timeIntervalSince(fromDate)
    }
    /// Stored as JSON strings in DB
    var entries: [Entry] {
        get {
            let decoder = JSONDecoder()
            do {
                let data = Data(entriesJSONString.utf8)
                return try decoder.decode([Entry].self, from: data)
            } catch {
                os_log("Failed to decode entry from Workout", log: .default, type: .error)
                return []
            }
        }
        set {
            let encoder = JSONEncoder()
            do {
                let data = try encoder.encode(newValue)
                entriesJSONString = String(data: data, encoding: .utf8)!
            } catch {
                os_log("Failed to encode entryString from entry", log: .default, type: .error)
            }
        }
    }
    
    convenience init(entries: [Workout.Entry]) {
        self.init()
        self.entries = entries
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func add(entry: Workout.Entry) {
        DatabaseManager.write { (_) in
            entries = entries + [entry]
        }
    }
    
    func add(entries: [Workout.Entry]) {
        DatabaseManager.write { (_) in
            self.entries = self.entries + entries
        }
    }
}

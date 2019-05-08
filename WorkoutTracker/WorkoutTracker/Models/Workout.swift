//
//  Workout.swift
//  WorkoutTracker
//
//  Created by Norman Lim on 8/5/2019.
//  Copyright © 2019 Norman Lim. All rights reserved.
//

import Foundation
import RealmSwift

class Workout: Object {
    @objc dynamic var date = Date()
    @objc dynamic var duration: Int = 0
    @objc dynamic var entriesJSONString = ""
    
    var entries: [Entry] {
        get {
            let decoder = JSONDecoder()
            do {
                let data = Data(entriesJSONString.utf8)
                return try decoder.decode([Entry].self, from: data)
            } catch {
                print("decode entries error")
                return []
            }
        }
        set {
            let encoder = JSONEncoder()
            do {
                let data = try encoder.encode(newValue)
                entriesJSONString = String(data: data, encoding: .utf8)!
            } catch {
                
            }
        }
    }
    
    override static func primaryKey() -> String? {
        return "date"
    }
    
    struct Entry: Codable {
        let exercise: Exercise
        let sets: [Int]
    }
}

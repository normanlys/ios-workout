//
//  Exercise.swift
//  WorkoutTracker
//
//  Created by Norman Lim on 8/5/2019.
//  Copyright © 2019 Norman Lim. All rights reserved.
//

import Foundation
import RealmSwift

class Exercise: Object, Codable {
    @objc dynamic var name = ""
    @objc dynamic var muscleGroupString = "chest"
    
    var muscleGroup: MuscleGroup {
        get { return MuscleGroup.init(rawValue: muscleGroupString)! }
        set { muscleGroupString = newValue.rawValue }
    }
    
    override static func primaryKey() -> String? {
        return "name"
    }
}

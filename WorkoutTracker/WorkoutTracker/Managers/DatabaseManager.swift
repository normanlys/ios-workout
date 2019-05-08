//
//  DatabaseManager.swift
//  WorkoutTracker
//
//  Created by Norman Lim on 8/5/2019.
//  Copyright © 2019 Norman Lim. All rights reserved.
//

import Foundation
import RealmSwift

struct DatabaseManager {
    static func write(block: (Realm) -> ()) {
        let realm = try! Realm()
        try! realm.write {
            block(realm)
        }
    }
    
    static func add(object: Object, update: Bool = true) {
        write { (realm) in
            realm.add(object, update: update)
        }
    }
    
    static func add(objects: [Object], update: Bool = true) {
        write { (realm) in
            realm.add(objects, update: update)
        }
    }
}

//
//  MuscleGroup.swift
//  WorkoutTracker
//
//  Created by Norman Lim on 5/5/2019.
//  Copyright © 2019 Norman Lim. All rights reserved.
//

import Foundation

/**
 Partitions of muscles
 
 Subclass string for the following reasons:
 1. Use .rawValue to get name of that group
 2. When adding new cases, using String instead of Int will prevent incorrect mapping from database to enum. Therefore, no need to strictly follow the order.
*/
enum MuscleGroup: String {
    case chest
    case shoulder
    case abdominal
    
    // arms
    case triceps
    case biceps
//    case forearms
    
    // legs
    case legs
    case calves
    
    // back
    case back
    case traps
}

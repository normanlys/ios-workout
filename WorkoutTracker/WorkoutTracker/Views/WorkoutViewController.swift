//
//  ExercisesViewController.swift
//  WorkoutTracker
//
//  Created by Norman Lim on 8/5/2019.
//  Copyright © 2019 Norman Lim. All rights reserved.
//

import UIKit

class WorkoutViewController: UIViewController {
    
    var workout = Workout(duration: 0, entries: [])

    override func viewDidLoad() {
        super.viewDidLoad()
        title = DateFormatter.standard.string(from: workout.date)
    }
}

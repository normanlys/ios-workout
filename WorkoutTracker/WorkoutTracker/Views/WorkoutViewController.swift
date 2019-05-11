//
//  ExercisesViewController.swift
//  WorkoutTracker
//
//  Created by Norman Lim on 8/5/2019.
//  Copyright © 2019 Norman Lim. All rights reserved.
//

import UIKit

class WorkoutViewController: UIViewController {
    
    var workout = Workout(entries: [])
    var isReadOnly = false

    override func viewDidLoad() {
        super.viewDidLoad()
        title = DateFormatter.standard.string(from: workout.fromDate)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !isReadOnly { workout.toDate = Date() }
        DatabaseManager.add(object: workout)
    }
}

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
    
    var datasource: [Workout.Entry] {
        return workout.entries
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = DateFormatter.standard.string(from: workout.fromDate)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !isReadOnly {
            DatabaseManager.write { (realm) in
                workout.toDate = Date()
            }
        }
        DatabaseManager.add(object: workout)
    }
}

extension WorkoutViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryTableCell")!
        let entry = datasource[indexPath.row]
        cell.textLabel?.text = entry.exercise.muscleGroup.rawValue.capitalized
        cell.detailTextLabel?.text = "\(entry.sets.count) sets"
        return cell
    }
    
    
}

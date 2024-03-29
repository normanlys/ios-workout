//
//  ExercisesViewController.swift
//  WorkoutTracker
//
//  Created by Norman Lim on 8/5/2019.
//  Copyright © 2019 Norman Lim. All rights reserved.
//

import UIKit

class WorkoutViewController: UIViewController {
    
    let cellReuseIdentifier = "EntryTableCell"
    
    var workout = Workout(entries: [])
    var isReadOnly = false
    
    var datasource: [Workout.Entry] {
        return workout.entries
    }
    
    @IBOutlet weak var tableView: UITableView!
    
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
        if workout.entries.count > 0 {
            DatabaseManager.add(object: workout)            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "addEntrySegue":
            let vc = (segue.destination as! UINavigationController).topViewController as! AddEntryViewController
            vc.delegate = self
        default:
            break
        }
    }
}

extension WorkoutViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let entry = datasource[indexPath.row]
        var cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)
        if cell == nil { cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellReuseIdentifier) }
        cell!.textLabel?.text = entry.exercise.muscleGroup.rawValue.capitalized
        cell!.detailTextLabel?.text = "\(entry.sets.count) sets"
        return cell!
    }
}

extension WorkoutViewController: AddEntryDelegate {
    func didSelectExercises(_ exercises: [Exercise]) {
        guard exercises.count > 0 else { return }
        let newEntries = exercises.map { Workout.Entry(exercise: $0, sets: []) }
        workout.add(entries: newEntries)
        tableView.reloadData()
    }
}

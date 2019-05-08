//
//  FirstViewController.swift
//  WorkoutTracker
//
//  Created by Norman Lim on 4/5/2019.
//  Copyright © 2019 Norman Lim. All rights reserved.
//

import UIKit
import RealmSwift

class HomeViewController: UIViewController {
    
    var workouts = { () -> Results<Workout> in
        let realm = try! Realm()
        return realm.objects(Workout.self)
    }()
    var selectedWorkout: Workout?
    
    var datasource: [TableItem] {
        return workouts.map { workout in
            return TableItem(muscleGroups: workout.entries.map { $0.exercise.muscleGroup },
                             date: workout.date,
                             duration: workout.duration)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "addWorkoutSegue":
            break
        case "viewWorkoutSegue":
            let vc = segue.destination as! WorkoutViewController
            vc.workout = selectedWorkout!
        default:
            break
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        let item = datasource[indexPath.row]
        
        cell.textLabel?.text = item.muscleGroups.map { $0.rawValue.capitalized }.joined(separator: ", ")
        cell.detailTextLabel?.text = [DateFormatter.standard.string(from: item.date),
                                      DateComponentsFormatter.standard.string(from: item.duration)!].joined(separator: ", ")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedWorkout = workouts[indexPath.row]
        return indexPath
    }
}

extension HomeViewController {
    struct TableItem {
        var muscleGroups: [MuscleGroup] = []
        var date: Date
        var duration: TimeInterval
    }
}

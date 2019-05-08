//
//  FirstViewController.swift
//  WorkoutTracker
//
//  Created by Norman Lim on 4/5/2019.
//  Copyright © 2019 Norman Lim. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var datasource: [TableItem] = []
    var dateFormatter = { () -> DateFormatter in
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
        formatter.calendar = Calendar.current
        return formatter
    }()
    var intervalFormatter = { () -> DateComponentsFormatter in
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.hour, .minute]
        return formatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        datasource = [
            TableItem(muscleGroups: [.chest], date: Date(), duration: TimeInterval(exactly: 1000)!),
            TableItem(muscleGroups: [.legs], date: Date(), duration: TimeInterval(exactly: 19000)!),
        ]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "addWorkoutSegue":
            break
        case "viewWorkoutSegue":
            break
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
        cell.detailTextLabel?.text = [dateFormatter.string(from: item.date), intervalFormatter.string(from: item.duration)!].joined(separator: ", ")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension HomeViewController {
    struct TableItem {
        var muscleGroups: [MuscleGroup] = []
        var date: Date
        var duration: TimeInterval
    }
}

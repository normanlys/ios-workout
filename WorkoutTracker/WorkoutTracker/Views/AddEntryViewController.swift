//
//  AddExerciseViewController.swift
//  WorkoutTracker
//
//  Created by Norman Lim on 12/5/2019.
//  Copyright © 2019 Norman Lim. All rights reserved.
//

import UIKit
import RealmSwift

class AddEntryViewController: UIViewController {
    
    var exercises: [Exercise] {
        let realm = try! Realm()
        return realm.objects(Exercise.self).sorted { $0.name < $1.name}
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
    }
    
    func configureSearchController() {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchResultsUpdater = self
        controller.obscuresBackgroundDuringPresentation = false
        
        controller.searchBar.placeholder = "Search Exercise"
        controller.searchBar.autocapitalizationType = .none
        controller.searchBar.returnKeyType = .done
        
        navigationItem.searchController = controller
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }

    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension AddEntryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addExerciseTableCell")!
        let exercise = exercises[indexPath.row]
        cell.textLabel?.text = exercise.name
        cell.detailTextLabel?.text = exercise.muscleGroup.rawValue.capitalized
        return cell
    }
}

extension AddEntryViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        return
    }
}

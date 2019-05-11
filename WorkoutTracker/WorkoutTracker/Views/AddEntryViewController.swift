//
//  AddExerciseViewController.swift
//  WorkoutTracker
//
//  Created by Norman Lim on 12/5/2019.
//  Copyright © 2019 Norman Lim. All rights reserved.
//

import UIKit
import RealmSwift

protocol AddEntryDelegate {
    func didSelectExercise(_ exercise: Exercise)
}

class AddEntryViewController: UIViewController {
    
    var delegate: AddEntryDelegate?
    var selectedExercise: Exercise?
    
    var exercises: [Exercise] {
//        let realm = try! Realm()
//        return realm.objects(Exercise.self).sorted { $0.name < $1.name}
        return [Exercise(name: "Test", muscleGroup: .abdominal)]
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
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
    
    @IBAction func addPressed(_ sender: Any) {
        guard let exercise = selectedExercise else {
            presentSimpleAlert(title: "Choose an Exercise First")
            return
        }
        delegate?.didSelectExercise(exercise)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedExercise = exercises[indexPath.row]
    }
}

extension AddEntryViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        return
    }
}

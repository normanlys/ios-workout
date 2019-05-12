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
    
    let exercises: [Exercise] = {
        //        let realm = try! Realm()
        //        return realm.objects(Exercise.self).sorted { $0.name < $1.name}
        return [Exercise(name: "Test", muscleGroup: .abdominal)]
    }()
    
    var delegate: AddEntryDelegate?
    var selectedExercise: Exercise?
    var datasource: [Exercise] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
    }
    
    private func configureTableView() {
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        datasource = exercises
        tableView.reloadData()
    }
    
    private func configureSearchController() {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchResultsUpdater = self
        controller.obscuresBackgroundDuringPresentation = false
        
        controller.searchBar.placeholder = "Search"
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
            presentSimpleAlert(title: "Choose an Exercise")
            return
        }
        delegate?.didSelectExercise(exercise)
        dismiss(animated: true, completion: nil)
    }
}

extension AddEntryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addExerciseTableCell")!
        let exercise = datasource[indexPath.row]
        cell.textLabel?.text = exercise.name
        cell.detailTextLabel?.text = exercise.muscleGroup.rawValue.capitalized
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedExercise = datasource[indexPath.row]
    }
}

extension AddEntryViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        if searchText.isEmpty {
            datasource = exercises
        } else {
            datasource = exercises.filter { $0.muscleGroupString.lowercased().contains(searchText) || $0.name.lowercased().contains(searchText) }
        }
        tableView.reloadData()
    }
}

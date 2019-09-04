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
    func didSelectExercises(_ exercises: [Exercise])
}

class AddEntryViewController: UIViewController {
    
    let cellReuseIdentifier = "addExerciseTableCell"
    
    var exercises: [Exercise] {
        //        let realm = try! Realm()
        //        return realm.objects(Exercise.self).sorted { $0.name < $1.name}
        return [Exercise(name: "Test", muscleGroup: .abdominal)]
    }
    
    var delegate: AddEntryDelegate?
    var datasource: [Exercise] = []
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    lazy var addButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSearchController()
        setupTableView()
        setupAddButton()
        setupNavigationBar()
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            ])
        
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        datasource = exercises
        tableView.reloadData()
    }
    
    private func setupSearchController() {
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
    
    fileprivate func setupAddButton() {
        addButton.setTitle("Add", for: .normal)
        addButton.backgroundColor = .blue
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.addTarget(self, action: #selector(addPressed(_:)), for: .touchUpInside)
        view.addSubview(addButton)
        let margin = CGFloat(8)
        NSLayoutConstraint.activate([
            addButton.heightAnchor.constraint(equalToConstant: 40),
            addButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: margin),
            addButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -margin),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -margin)
            ])
        addButton.layer.cornerRadius = addButton.frame.height/2
    }
    
    fileprivate func setupNavigationBar() {
        title = "Choose Exercise"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(closePressed(_:)))
    }
    
    // MARK: Actions

    @objc private func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func addPressed(_ sender: Any) {
        var selectedExercises: [Exercise] = []
        (0..<datasource.count).forEach { i in
            let cell = tableView.cellForRow(at: IndexPath(row: i, section: 0))!
            if cell.accessoryType == .checkmark {
                selectedExercises.append(exercises[i])
            }
        }
        delegate?.didSelectExercises(selectedExercises)
        dismiss(animated: true, completion: nil)
    }
}

extension AddEntryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) ?? UITableViewCell(style: .value1, reuseIdentifier: cellReuseIdentifier)
        let exercise = datasource[indexPath.row]
        cell.textLabel?.text = exercise.name
        cell.detailTextLabel?.text = exercise.muscleGroup.rawValue.capitalized
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath)!
        cell.accessoryType = cell.accessoryType == .none ? .checkmark : .none
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

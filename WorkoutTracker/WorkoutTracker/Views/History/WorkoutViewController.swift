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
    
    var entryViewModels: [EntryViewModel] {
        return workout.entries.map { EntryViewModel(entry: $0) }
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        setupTableView()
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
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            ])
    }
    
    fileprivate func setupNavigationBar() {
        title = DateFormatter.standard.string(from: workout.fromDate)
        if !isReadOnly {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPressed(_:)))
        }
    }
    
    // MARK: Actions
    @objc private func addPressed(_ sender: UIBarButtonItem) {
        let vc = AddEntryViewController()
        vc.delegate = self
        present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
}

extension WorkoutViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entryViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) ?? UITableViewCell(style: .subtitle, reuseIdentifier: cellReuseIdentifier)
        entryViewModels[indexPath.row].configure(cell: cell)
        return cell
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

extension WorkoutViewController {
    struct EntryViewModel {
        var entry: Workout.Entry
        
        func configure(cell: UITableViewCell) {
            cell.textLabel?.text = entry.exercise.muscleGroup.rawValue.capitalized
            cell.detailTextLabel?.text = "\(entry.sets.count) sets"
        }
    }
}

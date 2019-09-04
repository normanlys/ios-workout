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
    
    let cellReuseIdentifier = "Cell"
    
    var workouts: Results<Workout> {
        let realm = try! Realm()
        return realm.objects(Workout.self)
    }
    var datasource: [TableItem] {
        return workouts
            .sorted { $1.fromDate < $0.fromDate}
            .map { workout in
            return TableItem(muscleGroups: workout.entries.map { $0.exercise.muscleGroup },
                             date: workout.fromDate,
                             duration: workout.duration)
        }
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
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
        navigationItem.title = "History"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPressed(_:)))
    }
    
    // MARK: Actions
    
    @objc private func addPressed(_ sender: UITabBarItem) {
        navigationController?.pushViewController(WorkoutViewController(), animated: true)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) ?? UITableViewCell(style: .subtitle, reuseIdentifier: cellReuseIdentifier)
        let item = datasource[indexPath.row]
        
        cell.textLabel?.text = item.muscleGroups.map { $0.rawValue.capitalized }.joined(separator: ", ")
        cell.detailTextLabel?.text = [DateFormatter.standard.string(from: item.date),
                                      DateComponentsFormatter.standard.string(from: item.duration)!].joined(separator: ", ")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = WorkoutViewController()
        vc.workout = workouts[indexPath.row]
        vc.isReadOnly = true
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController {
    struct TableItem {
        var muscleGroups: [MuscleGroup] = []
        var date: Date
        var duration: TimeInterval
    }
}

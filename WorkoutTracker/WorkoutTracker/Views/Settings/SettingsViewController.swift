//
//  SecondViewController.swift
//  WorkoutTracker
//
//  Created by Norman Lim on 4/5/2019.
//  Copyright © 2019 Norman Lim. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    let cellReuseIdentifier = "cell"

    lazy var viewModels: [[ViewModel]] = [
        [
            ViewModel(name: "Sync With Health", accessoryView: {
                let view = UISwitch()
                view.setOn(false, animated: false)
                view.addTarget(self, action: #selector(setSyncWithHealth(_:)), for: .valueChanged)
                return view
            }())
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Settings"
    }
    
    @objc private func setSyncWithHealth(_ sender: UISwitch) {
         print(sender.isOn)
    }
}

extension SettingsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels[section].count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) ?? UITableViewCell(style: .default, reuseIdentifier: cellReuseIdentifier)
        viewModels[indexPath.section][indexPath.row].configure(cell: cell)
        return cell
    }
}

extension SettingsViewController {
    struct ViewModel {
        var name: String
        var accessoryView: UIView?
        
        init(name: String, accessoryView: UIView? = nil) {
            self.name = name
            self.accessoryView = accessoryView
        }
        
        func configure(cell: UITableViewCell) {
            cell.textLabel?.text = name
            cell.accessoryView = accessoryView
        }
    }
}

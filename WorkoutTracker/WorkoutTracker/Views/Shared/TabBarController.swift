//
//  TabBarController.swift
//  WorkoutTracker
//
//  Created by Norman Lim on 4/9/2019.
//  Copyright © 2019 Norman Lim. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let home = HomeViewController()
        home.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 0)
        let settings = SettingsViewController()
        settings.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)
        
        viewControllers = [home, settings].map {
            let navigation = UINavigationController(rootViewController: $0)
            navigation.navigationBar.prefersLargeTitles = true
            navigation.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            navigation.navigationBar.shadowImage = UIImage()
            return navigation
        }
    }
}

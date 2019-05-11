//
//  ViewControllerExtension.swift
//  WorkoutTracker
//
//  Created by Norman Lim on 12/5/2019.
//  Copyright © 2019 Norman Lim. All rights reserved.
//

import Foundation
import UIKit

typealias AlertActionHandler = (UIAlertAction) -> ()

extension UIViewController {
    func presentSimpleAlert(title: String?, message: String? = nil,
                            actionHandler: AlertActionHandler? = nil,
                            completion: (() -> ())? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Close", style: .default, handler: actionHandler)
        alert.addAction(action)
        present(alert, animated: true, completion: completion)
    }
}

//
//  UITableViewCellExtension.swift
//  WorkoutTracker
//
//  Created by Norman Lim on 8/9/2019.
//  Copyright © 2019 Norman Lim. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    class var nib: UINib {
        return UINib(nibName: "\(self)", bundle: nil)
    }
}

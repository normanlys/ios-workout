//
//  EntryTableViewCell.swift
//  WorkoutTracker
//
//  Created by Norman Lim on 8/9/2019.
//  Copyright © 2019 Norman Lim. All rights reserved.
//

import UIKit

class EntryTableViewCell: UITableViewCell {
    
    static let cornerRadius: CGFloat = 10

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberOfSetsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = EntryTableViewCell.cornerRadius
        containerView.layer.shadowOffset = CGSize(width: 1, height: 1)
        containerView.layer.shadowColor = UIColor.gray.cgColor
        containerView.layer.shadowOpacity = 0.5
        containerView.layer.shadowRadius = EntryTableViewCell.cornerRadius/2
    }
}

//
//  workoutsTableViewCell.swift
//  GymNotes
//
//  Created by Martin  on 16/05/16.
//  Copyright © 2016 Martin . All rights reserved.
//

import UIKit

class workoutsTableViewCell: UITableViewCell {

    @IBOutlet weak var workoutColorTagView: UIView!
    
    @IBOutlet weak var workoutLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

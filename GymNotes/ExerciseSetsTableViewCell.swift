//
//  ExerciseSetsTableViewCell.swift
//  GymNotes
//
//  Created by Martin  on 17/05/16.
//  Copyright © 2016 Martin . All rights reserved.
//

import UIKit

class ExerciseSetsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var setNumberLabel: UILabel!
    
    @IBOutlet weak var setRepsTxt: UITextField!
    
    @IBOutlet weak var setWeightTxt: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

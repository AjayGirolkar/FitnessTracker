//
//  TrainerTableViewCell.swift
//  FitnessTracker
//
//  Created by Ajay Girolkar on 10/07/22.
//

import UIKit

class TrainerTableViewCell: UITableViewCell {

    @IBOutlet weak var trainerLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

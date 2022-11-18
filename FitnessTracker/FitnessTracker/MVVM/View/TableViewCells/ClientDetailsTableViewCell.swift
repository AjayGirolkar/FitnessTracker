//
//  ClientDetailsTableViewCell.swift
//  FitnessTracker
//
//  Created by Shrey Bansal on 18/08/22.
//

import UIKit

class ClientDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var clientImageView: UIImageView!
    @IBOutlet weak var clientNameLabel: UILabel!
    @IBOutlet weak var clientAgeLabel: UILabel!
    @IBOutlet weak var clientContactNumberLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(user: User) {
        clientNameLabel.text = user.name
        clientAgeLabel.text = user.age?.toString() ?? ""
        clientContactNumberLabel.text = user.contactNumber
        usernameLabel.text = user.username
    }
}

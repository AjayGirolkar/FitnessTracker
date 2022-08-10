//
//  ReviewViewController.swift
//  FitnessTracker
//
//  Created by Ajay Girolkar on 13/07/22.
//

import UIKit

class ReviewViewController: UIViewController {
    
    @IBOutlet weak var clientMessageEditButton: UIButton!
    @IBOutlet weak var trainerMessageEditButton: UIButton!
    @IBOutlet weak var clientMessageTextView: UITextView!
    @IBOutlet weak var trainerMessageTextView: UITextView!
    
    var user: User = SharedManager.shared.user
    var isClientMessageEditModeOn: Bool = false
    var isTrainerMessageEditModeOn: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewForUser()
        trainerMessageTextView.isUserInteractionEnabled = false
        clientMessageTextView.isUserInteractionEnabled = false
    }
    
    func configureViewForUser() {
        if user.type == .client {
            trainerMessageEditButton.isUserInteractionEnabled = false
            trainerMessageEditButton.setImage(Image.lockImage, for: .normal)
        } else {
            clientMessageEditButton.isUserInteractionEnabled = false
            clientMessageEditButton.setImage(Image.lockImage, for: .normal)
        }
    }
    
    @IBAction func clientMessageButtonAction(_ sender: Any) {
        isClientMessageEditModeOn = !isClientMessageEditModeOn
        
        if isClientMessageEditModeOn {
            clientMessageTextView.isUserInteractionEnabled = true
            clientMessageEditButton.setImage(Image.doneImage, for: .normal)
        } else {
            clientMessageTextView.isUserInteractionEnabled = false
            clientMessageEditButton.setImage(Image.pencil, for: .normal)
        }
    }
    
    @IBAction func trainerMessageButtonAction(_ sender: Any) {
        isTrainerMessageEditModeOn = !isTrainerMessageEditModeOn
        
        if isTrainerMessageEditModeOn {
            trainerMessageTextView.isUserInteractionEnabled = true
            trainerMessageEditButton.setImage(Image.doneImage, for: .normal)
        } else {
            trainerMessageTextView.isUserInteractionEnabled = false
            trainerMessageEditButton.setImage(Image.pencil, for: .normal)
        }
    }
    
}

extension ReviewViewController: UITextViewDelegate {
    
}

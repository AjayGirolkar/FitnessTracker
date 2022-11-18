//
//  ReviewViewController.swift
//  FitnessTracker
//
//  Created by Shrey Bansal on 13/07/22.
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
    var clientModel: ClientModel?
    var reviewModel: ReviewModel? = ReviewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trainerMessageTextView.isUserInteractionEnabled = false
        clientMessageTextView.isUserInteractionEnabled = false
    }
    
    func congifureView(clientModel: ClientModel?) {
        self.clientModel = clientModel
        setupData()
        configureViewForUser()
    }
    
    func setupData() {
        if user.type == .client {
            reviewModel = user.reviewModel ?? reviewModel
            clientMessageTextView.text = reviewModel?.messageFromUser?.first ?? ""
            trainerMessageTextView.text = reviewModel?.messageToUser?.first ?? ""
        } else {
            updateReviewModel()
            clientMessageTextView.text = reviewModel?.messageFromUser?.first ?? ""
            trainerMessageTextView.text = reviewModel?.messageToUser?.first ?? ""
        }
    }
    
    func configureViewForUser() {
        if user.type == .client {
            trainerMessageEditButton.isUserInteractionEnabled = false
            trainerMessageEditButton.setImage(ImageName.lockImage, for: .normal)
            clientMessageEditButton.setTitle("Edit", for: .normal)
        } else {
            clientMessageEditButton.isUserInteractionEnabled = false
            clientMessageEditButton.setImage(ImageName.lockImage, for: .normal)
            trainerMessageEditButton.setTitle("Edit", for: .normal)
        }
    }
    
    @IBAction func clientMessageButtonAction(_ sender: Any) {
        isClientMessageEditModeOn = !isClientMessageEditModeOn
        reviewModel?.messageFromUser = [clientMessageTextView.text]

        if isClientMessageEditModeOn {
            clientMessageTextView.isUserInteractionEnabled = true
            clientMessageEditButton.setTitle("Save", for: .normal)
            //clientMessageEditButton.setImage(ImageName.doneImage, for: .normal)
        } else {
            clientMessageTextView.isUserInteractionEnabled = false
            clientMessageEditButton.setTitle("Edit", for: .normal)
            updateClientDetails()
            //clientMessageEditButton.setImage(ImageName.pencil, for: .normal)
        }
}
    
    @IBAction func trainerMessageButtonAction(_ sender: Any) {
        isTrainerMessageEditModeOn = !isTrainerMessageEditModeOn
        reviewModel?.messageToUser = [trainerMessageTextView.text]
        if isTrainerMessageEditModeOn {
            trainerMessageTextView.isUserInteractionEnabled = true
            trainerMessageEditButton.setTitle("Save", for: .normal)
            // trainerMessageEditButton.setImage(ImageName.doneImage, for: .normal)
        } else {
            trainerMessageTextView.isUserInteractionEnabled = false
            trainerMessageEditButton.setTitle("Edit", for: .normal)
            updateClientDetails()
            // trainerMessageEditButton.setImage(ImageName.pencil, for: .normal)
        }
    }
    
    func updateClientDetails() {
        saveData()
        updateExerciseForClient()
    }
    
    func saveData(){
        if var updatedClientModel = clientModel {
            updatedClientModel.reviewModel = reviewModel
            SharedManager.shared.user.clientList =  SharedManager.shared.user.clientList?.map({ clientModel in
                if clientModel.name == self.clientModel?.name {
                    return updatedClientModel
                }
                return clientModel
            })
            UserDefaultManager.shared.trySavingUser(user: SharedManager.shared.user, completion: nil)
        }
    }
    
    func updateReviewModel() {
        let username = self.clientModel?.username ?? user.username
        if let client = UserDefaultManager.shared.isUserAvailable(username: username) {
            reviewModel = client.reviewModel
        }
    }
    func updateExerciseForClient() {
        let username = self.clientModel?.username ?? user.username
        if var client = UserDefaultManager.shared.isUserAvailable(username: username) {
            client.reviewModel = reviewModel
            UserDefaultManager.shared.trySavingUser(user: client, completion: nil)
        }
    }
}

extension ReviewViewController: UITextViewDelegate {
    
}

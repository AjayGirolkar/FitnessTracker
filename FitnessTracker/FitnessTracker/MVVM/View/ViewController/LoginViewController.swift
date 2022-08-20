//
//  LoginViewController.swift
//  FitnessTracker
//
//  Created by Ajay Girolkar on 18/06/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SharedManager.setupDefaultData()
    }
    
    func authenticateUser() -> Bool {
        if let user = UserDefaultManager.shared.isValidUser(username: usernameTextField.text ?? "", password: passwordTextField.text ?? "") {
            errorLabel.isHidden = true
            SharedManager.shared.user = user
            self.user = user
            return true
        } else {
            errorLabel.isHidden = false
        }
        return false
    }
    
    @IBAction func singInAsUserAction(_ sender: Any) {
        if authenticateUser() {
            if let user = user {
                let trainerStoryBoard = UIStoryboard(name: "Trainer", bundle: .main)
                let clientDetailViewController = trainerStoryBoard.instantiateViewController(identifier: "ClientDetailViewController", creator: { coder -> ClientDetailViewController? in
                    let title = "Welcome, \(user.name)"
                    return ClientDetailViewController(coder: coder, navigationTitle: title,
                                                      exerciseList: user.excerciseList,
                                                      userType: user.type)
                })
                SharedManager.shared.user.type = .client
                let navViewController = UINavigationController(rootViewController: clientDetailViewController)
                navViewController.modalPresentationStyle = .fullScreen
                self.present(navViewController, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func singInAsTrainerAction(_ sender: Any) {
        if authenticateUser() {
            let trainerStoryBoard: UIStoryboard = UIStoryboard(name: "Trainer", bundle: nil)
            let newViewController = trainerStoryBoard.instantiateViewController(withIdentifier: "TrainerLandingVC") as! TrainerLandingVC
            let navViewController = UINavigationController(rootViewController: newViewController)
            navViewController.modalPresentationStyle = .fullScreen
            self.present(navViewController, animated: true, completion: nil)
            SharedManager.shared.user.type = .trainer
        }
    }
}

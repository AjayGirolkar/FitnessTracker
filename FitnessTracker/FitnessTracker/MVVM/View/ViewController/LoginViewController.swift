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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SharedManager.setupDefaultData()
    }
    
    func authenticateUser() -> Bool {
        if let user = UserDefaultManager.shared.isValidUser(username: usernameTextField.text ?? "", password: passwordTextField.text ?? "") {
            errorLabel.isHidden = true
            SharedManager.shared.user = user
            return true
        } else {
            errorLabel.isHidden = false
        }
        return true
    }
    
    @IBAction func singInAsUserAction(_ sender: Any) {
        if authenticateUser() {
            let userStoryBoard: UIStoryboard = UIStoryboard(name: "User", bundle: nil)
            let newViewController = userStoryBoard.instantiateViewController(withIdentifier: "UserLandingVC") as! UserLandingVC
            let navViewController = UINavigationController(rootViewController: newViewController)
            navViewController.modalPresentationStyle = .fullScreen
            self.present(navViewController, animated: true, completion: nil)
            SharedManager.shared.userType = .trainer
        }
    }
    
    @IBAction func singInAsTrainerAction(_ sender: Any) {
        if authenticateUser() {
            let trainerStoryBoard: UIStoryboard = UIStoryboard(name: "Trainer", bundle: nil)
            let newViewController = trainerStoryBoard.instantiateViewController(withIdentifier: "TrainerLandingVC") as! TrainerLandingVC
            let navViewController = UINavigationController(rootViewController: newViewController)
            navViewController.modalPresentationStyle = .fullScreen
            self.present(navViewController, animated: true, completion: nil)
            SharedManager.shared.userType = .client
        }
    }
}

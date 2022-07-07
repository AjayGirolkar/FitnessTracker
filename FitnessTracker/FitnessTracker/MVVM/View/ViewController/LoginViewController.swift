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
    }
    
    func authenticateUser() -> Bool {
        if (usernameTextField.text?.lowercased() == "shrey") && (passwordTextField.text == "12345") {
            errorLabel.isHidden = true
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
        }
    }
    
    @IBAction func singInAsTrainerAction(_ sender: Any) {
        if authenticateUser() {
            let trainerStoryBoard: UIStoryboard = UIStoryboard(name: "Trainer", bundle: nil)
            let newViewController = trainerStoryBoard.instantiateViewController(withIdentifier: "TrainerLandingVC") as! TrainerLandingVC
            let navViewController = UINavigationController(rootViewController: newViewController)
            navViewController.modalPresentationStyle = .fullScreen
            self.present(navViewController, animated: true, completion: nil)
        }
    }
}

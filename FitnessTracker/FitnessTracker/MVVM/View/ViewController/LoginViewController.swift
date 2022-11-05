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
    
    //This func used to check if user is available in database and show error if user is not present.
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
    
    //This func used to sign in using User role.
    @IBAction func signInAsUserAction(_ sender: Any) {
        if authenticateUser() { //Validate if user is valid
            SharedManager.shared.user.type = .client //Assign type to enum as client
            user = SharedManager.shared.user
            if let user = user {
                //Navigate to ClientDetailViewController and assign values through constructor.
                let trainerStoryBoard = UIStoryboard(name: "Trainer", bundle: .main)
                let clientDetailViewController = trainerStoryBoard.instantiateViewController(identifier: "ClientDetailViewController", creator: { coder -> ClientDetailViewController? in
                    let title = "Welcome, \(user.name)"
                    return ClientDetailViewController(coder: coder, navigationTitle: title,
                                                      exerciseList: user.excerciseList,
                                                      clientModel: nil,
                                                      userType: user.type)
                })
                //Create navigation controller to pass clientDetailViewController as rootViewController
                let navViewController = UINavigationController(rootViewController: clientDetailViewController)
                navViewController.modalPresentationStyle = .fullScreen
                self.present(navViewController, animated: true, completion: nil)
            }
        }
    }
    //This func used to sign in using Trainer role.
    @IBAction func signInAsTrainerAction(_ sender: Any) {
        if authenticateUser() {
            SharedManager.shared.user.type = .trainer
            //Navigate to TrainerLandingVC
            let trainerStoryBoard: UIStoryboard = UIStoryboard(name: "Trainer", bundle: nil)
            let newViewController = trainerStoryBoard.instantiateViewController(withIdentifier: "TrainerLandingVC") as! TrainerLandingVC
            let navViewController = UINavigationController(rootViewController: newViewController)
            navViewController.modalPresentationStyle = .fullScreen
            self.present(navViewController, animated: true, completion: nil)
        }
    }
}

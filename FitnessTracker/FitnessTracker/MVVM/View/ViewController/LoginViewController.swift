//
//  LoginViewController.swift
//  FitnessTracker
//
//  Created by Shrey Bansal on 18/06/22.
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
    func authenticateUser(completion: @escaping (Bool) -> Void) {
        FirebaseDatabaseManager().isValidUser(username: usernameTextField.text ?? "", password: passwordTextField.text ?? "", completion: { user in
            if let user = user {
                self.errorLabel.isHidden = true
                SharedManager.shared.user = user
                self.user = user
                completion(true)
            } else {
                self.errorLabel.isHidden = false
                completion(false)
            }
        })
    }
    
    //This func used to sign in using User role.
    @IBAction func signInAsUserAction(_ sender: Any) {
        authenticateUser(completion: { isSuccess in
            if isSuccess { //Validate if user is valid
                SharedManager.shared.user.type = .client //Assign type to enum as client
                self.user = SharedManager.shared.user
                if let user = self.user {
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
        })
    }
    
    //This func used to sign in using Trainer role.
    @IBAction func signInAsTrainerAction(_ sender: Any) {
        authenticateUser(completion: { isSuccess in
            if isSuccess {
                SharedManager.shared.user.type = .trainer
                //Navigate to TrainerLandingVC
                let trainerStoryBoard: UIStoryboard = UIStoryboard(name: "Trainer", bundle: nil)
                let newViewController = trainerStoryBoard.instantiateViewController(withIdentifier: "TrainerLandingVC") as! TrainerLandingVC
                let navViewController = UINavigationController(rootViewController: newViewController)
                navViewController.modalPresentationStyle = .fullScreen
                self.present(navViewController, animated: true, completion: nil)
            }})
    }
}

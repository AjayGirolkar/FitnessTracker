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
    

    @IBAction func singInAsUserAction(_ sender: Any) {
        
        let userStoryBoard: UIStoryboard = UIStoryboard(name: "User", bundle: nil)
        let newViewController = userStoryBoard.instantiateViewController(withIdentifier: "UserLandingVC") as! UserLandingVC
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: true, completion: nil)
    }
    
    @IBAction func singInAsTrainerAction(_ sender: Any) {
        
        let trainerStoryBoard: UIStoryboard = UIStoryboard(name: "Trainer", bundle: nil)
        let newViewController = trainerStoryBoard.instantiateViewController(withIdentifier: "TrainerLandingVC") as! TrainerLandingVC
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: true, completion: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

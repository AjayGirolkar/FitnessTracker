//
//  SignUpViewController.swift
//  FitnessTracker
//
//  Created by Ajay Girolkar on 01/07/22.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var validateEmailErrorLabel: UILabel!
    @IBOutlet weak var confirmPasswordErrorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addDismissKeyboardAction()
        
    }
    
    @IBAction func signUpAsTrainerButtonAction(_ sender: Any) {
        
        let isValidEmail = EmailValidator.isValidEmail(emailTextField.text ?? "")
        let isConfirmPasswordMatch = passwordTextField.text == confirmPasswordTextField.text
        
        if !isValidEmail{
            validateEmailErrorLabel.isHidden = false
        }
        if !isConfirmPasswordMatch {
            confirmPasswordErrorLabel.isHidden = false
        }
        
        if isValidEmail && isConfirmPasswordMatch {
            saveUserInUserDefaults(userType: .trainer)
        }
        
    }
    
    @IBAction func singUpAsUserButtonAction(_ sender: Any) {
        let isValidEmail = EmailValidator.isValidEmail(emailTextField.text ?? "")
        let isConfirmPasswordMatch = passwordTextField.text == confirmPasswordTextField.text
        
        if !isValidEmail{
            validateEmailErrorLabel.isHidden = false
        }
        if !isConfirmPasswordMatch {
            confirmPasswordErrorLabel.isHidden = false
        }
        
        if isValidEmail && isConfirmPasswordMatch {
            saveUserInUserDefaults(userType: .client)
        }
    }
    
    func saveUserInUserDefaults(userType: UserType) {
        if let name = nameTextField.text, !name.isEmpty,
           let username = usernameTextField.text, !username.isEmpty,
           let email = emailTextField.text, !email.isEmpty,
           let password = passwordTextField.text, !password.isEmpty {
            let user = User(name: name,
                            username: username,
                            email: email,
                            password: password,
                            type: userType,
                            age: nil,
                            clientList: userType == .trainer ? [] : nil)
            
            UserDefaultManager.shared.trySavingUser(user: user) { success in
                if success {
                    self.showAlertView(title: "Success!", message: "User is added", primaryButtonText: "Ok", primaryButtonAction:  {
                        self.dismiss(animated: true)
                        self.navigationController?.popViewController(animated: true)
                    })
                    self.validateEmailErrorLabel.isHidden = true
                    self.confirmPasswordErrorLabel.isHidden = true
                } else {
                    self.showAlertView(title: "Failed!", message: "Faile to save user", primaryButtonText: "Ok")
                }
            }
        }
    }
}


extension SignUpViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == usernameTextField {
            print("username text field is editing")
        }
        return true;
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // dismiss keyboard
        return true
    }
}

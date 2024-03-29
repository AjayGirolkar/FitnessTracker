//
//  UIViewController+Extension.swift
//  FitnessTracker
//
//  Created by Shrey Bansal on 04/08/22.
//

import UIKit

extension UIViewController {
    
    func updateNavigationBar() {
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.topItem?.title = " "
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "chevron.left")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(systemName: "chevron.left")
        navigationController?.navigationBar.tintColor = .black
    }
    
    func addDismissKeyboardAction(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func addLogoutButton() {
        let logoutButton = UIBarButtonItem(image: UIImage(systemName: "power"), style: .plain, target: self, action: #selector(logoutButtonAction))
        self.navigationController?.navigationBar.topItem?.setRightBarButton(logoutButton, animated: true)
    }
    
    @objc func logoutButtonAction() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController")
        loginVC.modalPresentationStyle = .fullScreen
        self.navigationController?.present(loginVC, animated: true)
    }
    
    func showAlertView(title: String, message: String, primaryButtonText: String,
                       primaryButtonAction: (() -> ())? = nil,
                       secondaryButtonText: String? = nil, secondaryButtonAction: (() -> ())? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {_ in
            primaryButtonAction?()
        }))
        if let secondaryButtonText = secondaryButtonText {
            alert.addAction(UIAlertAction(title: secondaryButtonText, style: .default, handler: { action in
                secondaryButtonAction?()
            }))
        }
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension UIView{

    func activityStartAnimating(activityColor: UIColor, backgroundColor: UIColor) {
        let backgroundView = UIView()
        backgroundView.frame = CGRect.init(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        backgroundView.backgroundColor = backgroundColor
        backgroundView.tag = 475647
        
        var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator = UIActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.center = self.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        activityIndicator.color = activityColor
        activityIndicator.startAnimating()
        self.isUserInteractionEnabled = false
        
        backgroundView.addSubview(activityIndicator)

        self.addSubview(backgroundView)
    }

    func activityStopAnimating() {
        if let background = viewWithTag(475647){
            background.removeFromSuperview()
        }
        self.isUserInteractionEnabled = true
    }
}

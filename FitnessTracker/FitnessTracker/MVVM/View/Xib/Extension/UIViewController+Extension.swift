//
//  UIViewController+Extension.swift
//  FitnessTracker
//
//  Created by Ajay Girolkar on 04/08/22.
//

import UIKit

extension UIViewController {
    
    func addDismissKeyboardAction(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
}

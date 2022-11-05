//
//  EmailValidator.swift
//  FitnessTracker
//
//  Created by Ajay Girolkar on 30/07/22.
//

import Foundation

//This class used to check if user entered valid Email address.
class EmailValidator {
    
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}" //Regex used to validate email.
        //Predicates represent logical conditions, which you can use to filter collections of objects
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}


//
//  SharedManager.swift
//  FitnessTracker
//
//  Created by Ajay Girolkar on 30/07/22.
//

import Foundation

class SharedManager {
    
    static let shared = SharedManager()
    var userType: UserType = .trainer
    var user: User?
}

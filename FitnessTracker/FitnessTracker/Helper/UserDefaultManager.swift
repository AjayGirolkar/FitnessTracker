//
//  UserDefaultManager.swift
//  FitnessTracker
//
//  Created by Ajay Girolkar on 30/07/22.
//

import Foundation

class UserDefaultManager {
    
    static let shared = UserDefaultManager()
    
    func isValidUser(username: String, password: String) -> User? {
        
        if let data = UserDefaults.standard.data(forKey: username) {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()
                
                // Decode Note
                let user = try decoder.decode(User.self, from: data)
                if user.username == username, user.password == password {
                    return user
                }
            } catch {
                print("Unable to Decode Note (\(error))")
            }
        }
        return nil
    }
    
    func trySavingUser(user: User, completion: (Bool) -> ()) {
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()
            
            // Encode Note
            let data = try encoder.encode(user)
            
            // Write/Set Data
            UserDefaults.standard.set(data, forKey: user.username)
            completion(true)
        } catch {
            print("Unable to Encode Note (\(error))")
            completion(false)
        }
    }
}

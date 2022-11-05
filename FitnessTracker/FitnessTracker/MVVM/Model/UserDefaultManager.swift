//
//  UserDefaultManager.swift
//  FitnessTracker
//
//  Created by Ajay Girolkar on 30/07/22.
//

import Foundation

class UserDefaultManager {
    
    static let shared = UserDefaultManager()
    
    //This func check if any user is present with entered username, password and return the user if already present.
    func isValidUser(username: String, password: String) -> User? {
        if let data = UserDefaults.standard.data(forKey: username) {
            do {
                let user = try JSONDecoder().decode(User.self, from: data)
                if user.username == username, user.password == password {
                    return user
                }
            } catch {
                print("Unable to Decode user (\(error))")
            }
        }
        return nil
    }
    
    //This func create new user once clicked on SignUp button. saving user in UserDefaults agains username key.
    func trySavingUser(user: User, completion: ((Bool) -> ())?) {
        do {
            let data = try JSONEncoder().encode(user)
            UserDefaults.standard.set(data, forKey: user.username)
            completion?(true)
        } catch {
            print("Unable to Encode user (\(error))")
            completion?(false)
        }
    }
    
    //This func validate if user available for given username.
    func isUserAvailable(username: String) -> User? {
        if let data = UserDefaults.standard.data(forKey: username) {
            do {
               let user = try JSONDecoder().decode(User.self, from: data)
                if user.username == username {
                    return user
                }
            } catch {
                print("Unable to Found user (\(error))")
            }
        }
        return nil
    }
    
    func getExerciseList() -> [Exercise]? {
        if let data = UserDefaults.standard.data(forKey: "exerciseList") {
            do {
               let exerciseList = try JSONDecoder().decode([Exercise].self, from: data)
                return exerciseList
            } catch {
                print("Unable to Found user (\(error))")
            }
        }
        return nil
    }
    
    func saveExerciseList(exerciseList: [Exercise], completion: (Bool) -> ()) {
        do {
            let data = try JSONEncoder().encode(exerciseList)
            UserDefaults.standard.set(data, forKey: "exerciseList")
            completion(true)
        } catch {
            print("Unable to Encode user (\(error))")
            completion(false)
        }
    }
}

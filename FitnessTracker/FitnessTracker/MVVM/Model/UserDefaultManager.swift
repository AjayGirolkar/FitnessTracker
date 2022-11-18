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
    func isValidUser(username: String, password: String, completion: @escaping (User?) -> Void) {
        FirebaseDatabaseManager().isValidUser(username: username, password: password) { userData in
            if let userData = userData {
                completion(userData)
            } else  if let data = UserDefaults.standard.data(forKey: username) {
                do {
                    let user = try JSONDecoder().decode(User.self, from: data)
                    if user.username == username, user.password == password {
                        completion(user)
                    }
                } catch {
                    print("Unable to Decode user (\(error))")
                    completion(nil)
                }
            }
        }
    }
    
    //This func create new user once clicked on SignUp button. saving user in UserDefaults agains username key.
    func trySavingUser(user: User, completion: ((Bool) -> ())?) {
        FirebaseDatabaseManager().trySavingUser(user: user) { isSuccess in
            let data = try? JSONEncoder().encode(user)
            UserDefaults.standard.set(data, forKey: user.username)
            completion?(isSuccess)
        }
    }
    
    //This func validate if user available for given username.
    func isUserAvailable(username: String) -> User? {
        if let user = FirebaseDatabaseManager().isUserAvailable(username: username) {
            return user
        } else {
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
    }
    
    func getExerciseList() -> [Exercise]? {
        FirebaseDatabaseManager().getExerciseList { exerciseList in
            if let exerciseList = exerciseList {
                print(exerciseList)
            }
        }
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
        FirebaseDatabaseManager().saveExerciseList(exerciseList: exerciseList) { success in
            
        }
        
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

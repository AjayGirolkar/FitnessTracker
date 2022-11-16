//
//  FirebaseDatabaseManager.swift
//  FitnessTracker
//
//  Created by Ajay Girolkar on 11/11/22.
//

import Foundation
import FirebaseFirestore
import Firebase
import FirebaseStorage

class FirebaseDatabaseManager {
    
    let storage = Storage.storage()
    let database = Firestore.firestore()
    
    func isValidUser(username: String, password: String, completion: @escaping (User?) -> Void) {
        var user: User? = nil
        let userRef = database.collection("fitnessTrackerApp").document("fitnessTrackerApp-id1").collection("Users")
        userRef.getDocuments { snapshot, error in
            if let _ = error {
                return completion(nil)
            } else {
                if let documents = snapshot?.documents {
                    for document in documents {
                        if let userData = self.convertToUser(response: document.data()) {
                            if userData.username == username, userData.password == password {
                                return completion(user)
                            } else {
                                //return completion(nil)
                            }
                        }
                    }
                }
                return completion(nil)
            }
        }
    }
    
    func convertToUser(response: [String : Any]) -> User? {
        var user: User?
        var clientList: [ClientModel]?
        var excerciseList: [Exercise]?
        var reviewModel: ReviewModel?
        var name = ""
        var username = ""
        var email = ""
        var password = ""
        var contactNumber = ""
        var type = ""
        var age = 0
        var id = ""
        if let idValue = response["id"] as? String {
            id = idValue
        }
        if let nameString = response["name"] as? String {
            name = nameString
        }
        if let usernameValue = response["username"] as? String {
            username = usernameValue
        }
        if let emailValue = response["email"] as? String {
            email = emailValue
        }
        if let passwordValue = response["password"] as? String {
            password = passwordValue
        }
        if let contactNumberValue = response["contactNumber"] as? String {
            contactNumber = contactNumberValue
        }
        if let ageValue = response["age"] as? Int {
            age = ageValue
        }
        if let clientListId = response["clientListId"] as? String {
            
        }
        if let excerciseListId = response["excerciseListId"] as? String {
            
        }
        if let reviewModel = response["reviewModel"] as? String {
            
        }
        if let exerciseListString = response["exerciseList"] as? String {
            excerciseList = try? JSONDecoder().decode([Exercise].self, from: Data(exerciseListString.utf8))
        }
        
        let userType = UserType(rawValue: type) ?? .client
        user = User(name: id, username: username, email: email, password: password, type: userType, age: age, clientList: clientList, excerciseList: excerciseList, reviewModel: reviewModel)
        return user
        
    }
    
    //This func create new user once clicked on SignUp button. saving user in UserDefaults agains username key.
    func trySavingUser(user: User, completion: ((Bool) -> ())?) {
        let id =  UUID().uuidString
        var exerciseListString = ""
        do {
            if let exerciseListStringData = try? JSONEncoder().encode(SharedManager.shared.getAvailableExerciseList()) {
                exerciseListString = String(data: exerciseListStringData, encoding: .utf8) ?? ""
            }
        }
        let excerciseListString = user.excerciseList
        let userData: [String: Any] = ["id": id,
                                       "name"  : user.name,
                                       "username"  : user.username,
                                       "email"  : user.email,
                                       "password"  : user.password,
                                       "contactNumber"  : user.contactNumber,
                                       "type"  : user.type.rawValue,
                                       "age"  : user.age,
                                       "clientListId" : id,
                                       "excerciseListId": id,
                                       "exerciseList": exerciseListString,
                                       "reviewModel": id
        ]
        
        database.collection("fitnessTrackerApp/fitnessTrackerApp-id1/Users").addDocument(data: userData) {error in
            if error == nil {
                completion?(true)
            } else {
                completion?(false)
            }
        }
    }
}

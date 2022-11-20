//
//  FirebaseDatabaseManager.swift
//  FitnessTracker
//
//  Created by Shrey Bansal on 11/11/22.
//

import Foundation
import FirebaseFirestore
import Firebase
import FirebaseStorage

class FirebaseDatabaseManager {
    
    let storage = Storage.storage()
    let database = Firestore.firestore()
    
    func isValidUser(username: String, password: String, completion: @escaping (User?) -> Void) {
        //Database reference to connect to database.
        let userRef = database.collection("fitnessTrackerApp").document("fitnessTrackerApp-id1").collection("Users")
        
        //API call to get all data from database
        userRef.getDocuments { snapshot, error in
            if let _ = error {
                return completion(nil)
            } else {
                if let documents = snapshot?.documents {
                    SharedManager.shared.totalUsers.removeAll()
                    //Get list of all items present inside database collection.
                    for document in documents {
                        let response = document.data()
                        if let user = self.convertToUser(response: response, id: document.documentID) {
                            SharedManager.shared.totalUsers.append(user)
                        }
                    }
                    let availableUser = SharedManager.shared.totalUsers.filter({ userData in
                        //Validate if username enter by user is available in database.
                        if userData.username == username, userData.password == password {
                            return true
                        }
                        return false
                    }).first
                    if let user = availableUser {
                        //Return valid user if present
                        return completion(user)
                    }
                    
                }
                return completion(nil)
            }
        }
    }
    
    //Convert database JSON response into swift codable model
    func convertToUser(response: [String : Any], id: String) -> User? {
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
        var imageName = ""
        
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
        if let clientListString = response["clientList"] as? String {
            clientList = try? JSONDecoder().decode([ClientModel].self, from: Data(clientListString.utf8))
        }
        
        if let reviewModelString = response["reviewModel"] as? String {
            reviewModel = try? JSONDecoder().decode(ReviewModel.self, from: Data(reviewModelString.utf8))
            
        }
        if let exerciseListString = response["exerciseList"] as? String {
            excerciseList = try? JSONDecoder().decode([Exercise].self, from: Data(exerciseListString.utf8))
        }
        if let imageNameString = response["imageName"] as? String {
            imageName = imageNameString
        }
        if let typeString = response["type"] as? String {
            type = typeString
        }
        
        let userType = UserType(rawValue: type) ?? .client
        //Convert to swift model.
        user = User(id: id, name: name, username: username, email: email, password: password, contactNumber: contactNumber, type: userType, age: age, imageName: imageName, clientList: clientList, excerciseList: excerciseList, reviewModel: reviewModel)
        return user
        
    }
    
    //This func create new user once clicked on SignUp button. saving user in UserDefaults agains username key.
    func trySavingUser(user: User, completion: ((Bool) -> ())?) {
        let id =  user.id.isEmpty ? UUID().uuidString : user.id
        var exerciseListString = ""
        var clientListString = ""
        var reviewModelString = ""
        do {
            if let exerciseListStringData = try? JSONEncoder().encode(user.excerciseList) {
                exerciseListString = String(data: exerciseListStringData, encoding: .utf8) ?? ""
            }
            if let clientListData = try? JSONEncoder().encode(user.clientList) {
                clientListString = String(data: clientListData, encoding: .utf8) ?? ""
            }
            if let reviewModelData = try? JSONEncoder().encode(user.reviewModel) {
                reviewModelString = String(data: reviewModelData, encoding: .utf8) ?? ""
            }
        }
        let userData: [String: Any] = ["id": id,
                                       "name"  : user.name,
                                       "username"  : user.username,
                                       "email"  : user.email,
                                       "password"  : user.password,
                                       "contactNumber"  : user.contactNumber,
                                       "type"  : user.type.rawValue,
                                       "age"  : user.age ?? 0,
                                       "imagename": user.imageName,
                                       "clientList" : clientListString,
                                       "exerciseList": exerciseListString,
                                       "reviewModel": reviewModelString
        ]
        database.collection("fitnessTrackerApp/fitnessTrackerApp-id1/Users").document(id).setData(userData){error in
            if error == nil {
                completion?(true)
            } else {
                completion?(false)
            }
        }
    }
    
    //This func validate if user available for given username.
    func isUserAvailable(username: String) -> User? {
        let userList = SharedManager.shared.totalUsers
        return userList.filter{$0.username.lowercased() == username.lowercased()}.first
    }
    
    func getExerciseList(completion: @escaping ([Exercise]?) -> Void) {
        var exerciseList : [Exercise]? = nil
        //Get exercise list path
        let userRef = database.collection("fitnessTrackerApp").document("fitnessTrackerApp-id1")
        //API call to get exercise
        userRef.getDocument { snapshot, error in
            if error != nil {
                completion(nil)
            } else {
                if let documents = snapshot?.data()?["ExerciseList"] as? String {
                    exerciseList = try? JSONDecoder().decode([Exercise].self, from: Data(documents.utf8))
                    completion(exerciseList)
                }
                completion(nil)
            }}
    }
    
    func saveExerciseList(exerciseList: [Exercise], completion: @escaping (Bool) -> ()) {
        var exerciseListString = ""
        if let exerciseListStringData = try? JSONEncoder().encode(exerciseList) {
            exerciseListString = String(data: exerciseListStringData, encoding: .utf8) ?? ""
        }
        database.document("fitnessTrackerApp/fitnessTrackerApp-id1").setData(["ExerciseList": exerciseListString]) { error in
            if error == nil {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}

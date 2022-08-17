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
    var user: User = User(name: "", username: "", email: "", password: "", type: .client, age: nil, clientModel: nil)
    
    static func setupDefaultData() {
                
       
        let exerciseList = SharedManager.shared.getAvailableExerciseList()
        let reviewModel = ReviewModel(messageToUser: ["Hey Please follow exerise showing on your timeline"],
                                 messageFromUser: ["Sure, I am following those exerise. Its great!"])
        
        let clientList = [ClientModel(name: "Shrey", age: 20,
                                      exerciseList: exerciseList,
                                      reviewModel: reviewModel),
                          ClientModel(name: "Ajay", age: 29,
                                      exerciseList: exerciseList,
                                      reviewModel: reviewModel),
                          ClientModel(name: "Avenger", age: 40,
                                      exerciseList: exerciseList,
                                      reviewModel: reviewModel),
                          ClientModel(name: "Thor", age: 15,
                                      exerciseList: exerciseList,
                                      reviewModel: reviewModel),
                          ClientModel(name: "Hulk", age: 30,
                                      exerciseList: exerciseList,
                                      reviewModel: reviewModel),
                          ClientModel(name: "Iron Man", age: 35,
                                      exerciseList: exerciseList,
                                      reviewModel: reviewModel)]
        if let user = UserDefaultManager.shared.isUserAvailable(username: "shrey@gmail.com") {
            shared.user = user
            return //user already present
        }
        shared.user = User(name: "Shrey", username: "shrey@gmail.com", email: "shrey@gmail.com", password: "Shrey@123", type: .client, age: 20, clientModel: clientList, excerciseList: exerciseList, reviewModel: reviewModel)
        UserDefaultManager.shared.trySavingUser(user: SharedManager.shared.user) { success in
            print("user saved successfully")
        }
    }
    
    func getAvailableExerciseList() -> [Exercise] {
        if let exerciseList = UserDefaultManager.shared.getExerciseList() {
            return exerciseList
        } else {
            let exerciseList = [Exercise(exericiseName: "Barberll curl",
                                          imageName: ExerciseName.barbellCurl,
                                          repetition: 5, set: 3, weight: 10, isExerciseOn: true),
                                Exercise(exericiseName: "Chest press",
                                          imageName: ExerciseName.chestpress,
                                          repetition: 5, set: 3, weight: 10, isExerciseOn: true),
                                Exercise(exericiseName: "Bridge Exercisel",
                                          imageName: ExerciseName.bridgeExercise,
                                          repetition: 5, set: 3, weight: 10, isExerciseOn: true),
                                Exercise(exericiseName: "Crunches",
                                          imageName: ExerciseName.crunches,
                                          repetition: 5, set: 3, weight: 10, isExerciseOn: true),
                                Exercise(exericiseName: "Lunges",
                                          imageName: ExerciseName.lunges,
                                          repetition: 5, set: 3, weight: 10, isExerciseOn: true),
                                Exercise(exericiseName: "Leg extension",
                                          imageName: ExerciseName.legExtension,
                                          repetition: 5, set: 3, weight: 10, isExerciseOn: true),
                                Exercise(exericiseName: "Shoulder Press",
                                          imageName: ExerciseName.shoulderPress,
                                          repetition: 5, set: 3, weight: 10, isExerciseOn: true),
                                Exercise(exericiseName: "Pull ups",
                                          imageName: ExerciseName.pullups,
                                          repetition: 5, set: 3, weight: 10, isExerciseOn: true),
                                Exercise(exericiseName: "Squates",
                                          imageName: ExerciseName.squat,
                                          repetition: 5, set: 3, weight: 10, isExerciseOn: true),
                                Exercise(exericiseName: "T Bar Row",
                                          imageName: ExerciseName.tBarRow,
                                          repetition: 5, set: 3, weight: 10, isExerciseOn: true),
                                Exercise(exericiseName: "Barberll curl",
                                          imageName: ExerciseName.barbellCurl,
                                          repetition: 5, set: 3, weight: 10, isExerciseOn: true),
                                Exercise(exericiseName: "Barberll curl",
                                          imageName: ExerciseName.barbellCurl,
                                          repetition: 5, set: 3, weight: 10, isExerciseOn: true),
                                Exercise(exericiseName: "Barberll curl",
                                          imageName: ExerciseName.barbellCurl,
                                          repetition: 5, set: 3, weight: 10, isExerciseOn: true)]
            UserDefaultManager.shared.saveExerciseList(exerciseList: exerciseList) { success in
                print("exercise list saved successfully")
            }
            return exerciseList
        }
    }
}

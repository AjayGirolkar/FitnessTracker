//
//  SharedManager.swift
//  FitnessTracker
//
//  Created by Ajay Girolkar on 30/07/22.
//

import Foundation

class SharedManager {
    
    static let shared = SharedManager()
    var user: User = User(name: "", username: "", email: "", password: "", type: .client, age: nil, clientList: [])
    
    static func setupDefaultData() {
        
        
        let exerciseList = SharedManager.shared.getAvailableExerciseList()
        let reviewModel = ReviewModel(messageToUser: ["Hey Please follow exerise showing on your timeline"],
                                      messageFromUser: ["Sure, I am following those exerise. Its great!"])
        
        let clientList = [ClientModel(name: "Shrey",
                                      username: "shrey@gmail.com",
                                      age: "20",
                                      exerciseList: exerciseList,
                                      reviewModel: reviewModel),
                          ClientModel(name: "Ajay", age: "29",
                                      exerciseList: exerciseList,
                                      reviewModel: reviewModel),
                          ClientModel(name: "Avenger", age: "40",
                                      exerciseList: exerciseList,
                                      reviewModel: reviewModel),
                          ClientModel(name: "Thor", age: "15",
                                      exerciseList: exerciseList,
                                      reviewModel: reviewModel),
                          ClientModel(name: "Hulk", age: "30",
                                      exerciseList: exerciseList,
                                      reviewModel: reviewModel),
                          ClientModel(name: "Iron Man", age: "35",
                                      exerciseList: exerciseList,
                                      reviewModel: reviewModel)]
        if let user = UserDefaultManager.shared.isUserAvailable(username: "shrey@gmail.com") {
            shared.user = user
            return //user already present
        }
        shared.user = User(name: "Shrey", username: "shrey@gmail.com", email: "shrey@gmail.com", password: "Shrey@123", type: .client, age: 20, clientList: clientList, excerciseList: exerciseList, reviewModel: reviewModel)
        UserDefaultManager.shared.trySavingUser(user: SharedManager.shared.user) { success in
            print("user saved successfully")
        }
    }
    
    func getAvailableExerciseList() -> [Exercise] {
        if let exerciseList = UserDefaultManager.shared.getExerciseList() {
            return exerciseList
        } else {
            let exerciseList = [Exercise(exericiseName: "Lat pull down",
                                         imageName: ExerciseName.latPullDown,
                                         repetition: 5, set: 3, weight: 10, isExerciseOn: true,
                                         exerciseDescription: ExerciseDescriptions.latPullDown),
                                Exercise(exericiseName: "Dumbbell Curl",
                                         imageName: ExerciseName.dumbbellCurl,
                                         repetition: 5, set: 3, weight: 10, isExerciseOn: true,
                                         exerciseDescription: ExerciseDescriptions.dumbbellCurl),
                                Exercise(exericiseName: "Chest Press",
                                         imageName: ExerciseName.chestPress,
                                         repetition: 5, set: 3, weight: 10, isExerciseOn: true,
                                         exerciseDescription: ExerciseDescriptions.chestPress),
                                Exercise(exericiseName: "Crunches",
                                         imageName: ExerciseName.crunches,
                                         repetition: 5, set: 3, weight: 10, isExerciseOn: true,
                                         exerciseDescription: ExerciseDescriptions.crunches),
                                Exercise(exericiseName: "Concentration Dumbbell Curl",
                                         imageName: ExerciseName.concentrationCurl,
                                         repetition: 5, set: 3, weight: 10, isExerciseOn: true,
                                         exerciseDescription: ExerciseDescriptions.concentrationCurl),
                                Exercise(exericiseName: "Pull ups",
                                         imageName: ExerciseName.pullUps,
                                         repetition: 5, set: 3, weight: 10, isExerciseOn: true,
                                         exerciseDescription: ExerciseDescriptions.pullUps),
                                Exercise(exericiseName: "Push Ups",
                                         imageName: ExerciseName.pushUps,
                                         repetition: 5, set: 3, weight: 10, isExerciseOn: true,
                                         exerciseDescription: ExerciseDescriptions.pushUps),
                                Exercise(exericiseName: "Squat",
                                         imageName: ExerciseName.squat,
                                         repetition: 5, set: 3, weight: 10, isExerciseOn: true,
                                         exerciseDescription: ExerciseDescriptions.squat)]
            UserDefaultManager.shared.saveExerciseList(exerciseList: exerciseList) { success in
                print("exercise list saved successfully")
            }
            return exerciseList
        }
    }
}

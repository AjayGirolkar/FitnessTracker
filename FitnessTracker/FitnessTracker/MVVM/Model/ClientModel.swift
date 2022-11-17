//
//  ClientModel.swift
//  FitnessTracker
//
//  Created by Ajay Girolkar on 11/07/22.
//

import Foundation

//Enum to distinguish user role as trainer vs client
enum UserType: String, Codable {
    case client
    case trainer
}

//Codable model to store and retrieve client information from UserDefaults.
struct ClientModel: Codable {
    var name: String
    var username: String = ""
    var age: String?
    var imageData: Data?
    var exerciseList: [Exercise]?
    var reviewModel: ReviewModel?
}

//Codable model to store and retrieve Exercise information from UserDefaults.
struct Exercise: Codable {
    var id = UUID().uuidString
    var exericiseName: String
    var imageName: String = ""
    var imageData: Data? = nil
    var repetition: Int
    var set: Int
    var weight: Int
    var isExerciseOn: Bool = false
    var exerciseDescription: String = ""
}

struct ReviewModel: Codable {
    var messageToUser: [String]?
    var messageFromUser: [String]?
}


struct User: Codable {
    var id: String = ""
    var name: String
    var username: String
    var email: String
    let password: String
    var contactNumber: String = ""
    var type: UserType
    let age: Int?
    var imageName: String = ""
    var imageData: Data?
    var clientList: [ClientModel]?
    var excerciseList: [Exercise]?
    var reviewModel: ReviewModel?
}

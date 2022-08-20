//
//  ClientModel.swift
//  FitnessTracker
//
//  Created by Ajay Girolkar on 11/07/22.
//

import Foundation

enum UserType: String, Codable {
    case client
    case trainer
}

struct ClientModel: Codable {
    var name: String
    var age: String?
    var imageData: Data?
    var exerciseList: [Exercise]?
    var reviewModel: ReviewModel?
}

struct Exercise: Codable {
    var exericiseName: String
    var imageName: String = ""
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
    let name: String
    let username: String
    let email: String
    let password: String
    var contactNumber: String = ""
    var type: UserType
    let age: Int?
    var imageData: Data?
    var clientList: [ClientModel]?
    var excerciseList: [Exercise]?
    var reviewModel: ReviewModel?
}

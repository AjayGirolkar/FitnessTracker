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
    let name: String
    let age: Int?
    var imageName: String?
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
    let type: UserType
    let age: Int?
    var clientModel: [ClientModel]?
    var excerciseList: [Exercise]?
    var reviewModel: ReviewModel?
}

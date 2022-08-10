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
    var excerciseList: [Excercise]?
    var reviewModel: ReviewModel?
}

struct Excercise: Codable {
    var exericiseName: String
    var imageName: String = ""
    var repetition: Int
    var set: Int
    var weight: Int
    var isExerciseOn: Bool = false
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
    let clientModel: ClientModel?
}

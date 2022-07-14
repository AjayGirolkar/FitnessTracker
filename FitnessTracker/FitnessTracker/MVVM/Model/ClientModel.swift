//
//  ClientModel.swift
//  FitnessTracker
//
//  Created by Ajay Girolkar on 11/07/22.
//

import Foundation

struct ClientModel {
    let name: String
    let age: Int?
    var imageName: String?
    var excerciseList: [Excercise]?
    var reviewModel: ReviewModel?
}

struct Excercise {
    var exericiseName: String
    var imageName: String = ""
    var repetition: Int
    var set: Int
    var weight: Int
    var isExerciseOn: Bool = false
}

struct ReviewModel {
    var messageToUser: [String]?
    var messageFromUser: [String]?
}

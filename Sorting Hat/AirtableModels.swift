//
//  AirtableModels.swift
//  Sorting Hat
//
//  Created by Joshua Botts on 3/23/21.
//  Copyright © 2021 Joshua Botts. All rights reserved.
//

import Foundation

protocol AirtableModel {
    var offset: String? {get set}
}

enum AirtableTables: String {
    case destinations = "Destinations"
    case questions = "Questions"
    case choices = "Choices"
    case scores = "Scores"
    case names = "Names"
}

struct AirtableDestinationRecords: Codable, AirtableModel {
    var records: [AirtableDestination]
    var offset: String?
}

struct AirtableDestination: Codable {
    struct Attachment: Codable {
        let id: String
        let url: URL
        let filename: String
        let size: Int
        let type: String
    }
    
    struct Fields: Codable {
        let name: String
        let description: String
        let movie: [AirtableDestination.Attachment]
        let scores: [String]
        let badge: [AirtableDestination.Attachment]?
        let count: Int?
    }
    
    let id: String
    let createdTime: String
    let fields: AirtableDestination.Fields
    
}

struct AirtableChoiceRecords: Codable, AirtableModel {
    var records: [AirtableChoice]
    var offset: String?
}

struct AirtableChoice: Codable {
    struct Attachment: Codable {
        let id: String
        let url: URL
        let filename: String
        let size: Int
        let type: String
    }
    
    struct Fields: Codable {
        let choice: String
        let question: [String]
        let scores: [String]
        let image: [AirtableChoice.Attachment]?
        let count: Int?
    }
    
    let id: String
    let createdTime: String
    let fields: AirtableChoice.Fields
    
}

struct AirtableQuestionRecords: Codable, AirtableModel {
    var records: [AirtableQuestion]
    var offset: String?
}

struct AirtableQuestion: Codable {
    struct Fields: Codable {
        let question: String
        let number: Int
        let choices: [String]
        let kidsMode: Bool?
        let count: Int?
    }
    
    let id: String
    let createdTime: String
    let fields: AirtableQuestion.Fields
    
}

struct AirtableScoreRecords: Codable, AirtableModel {
    var records: [AirtableScore]
    var offset: String?
}

struct AirtableScore: Codable {
    struct Fields: Codable {
        let destinationScore: String
        let destination: [String]
        let points: String
        let choices: [String]?
        let names: [String]?
    }
    
    let id: String
    let createdTime: String
    let fields: AirtableScore.Fields
    
}

struct AirtableNameRecords: Codable, AirtableModel {
    var records: [AirtableName]
    var offset: String?
}

struct AirtableName: Codable {
    struct Fields: Codable {
        let name: String
        let scores: [String]
    }
    
    let id: String
    let createdTime: String
    let fields: AirtableName.Fields
}

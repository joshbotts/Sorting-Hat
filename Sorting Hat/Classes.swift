//
//  Classes.swift
//  Sorting Hat
//
//  Created by Joshua Botts on 4/15/20.
//  Copyright © 2020 Joshua Botts. All rights reserved.
//

import Foundation
import Combine
import SwiftUI
import AVKit

struct SortingDestination: Decodable, Hashable, Equatable, CustomStringConvertible {
    let id: String
    let name: String
    let descriptionFull: String
    let description: String
    
    init(id: String, name: String, descriptionFull: String) {
        self.id = id
        self.name = name
        self.descriptionFull = descriptionFull
        self.description = name
    }
    
    static func == (lhs: SortingDestination, rhs: SortingDestination) -> Bool {
        if lhs.name == rhs.name && lhs.descriptionFull == rhs.descriptionFull {
            return true
        } else {
            return false
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(descriptionFull)
    }
}

class User: ObservableObject {
    @Published var name: String
    @Published var sortingScores: Dictionary<SortingDestination, Int>?
    
    init(_ name: String) {
        self.name = name
    }
}


class ScoreForName: Decodable {
    let id: String
    let userNameString: String
    var nameScoresForDestinationsDict: Dictionary<SortingDestination, String> {
        var dictionary = Dictionary<SortingDestination, String>()
        for nameScore in self.nameScoresForDestinationsStruct {
            dictionary[nameScore.destination] = nameScore.score
        }
        return dictionary
    }
    let nameScoresForDestinationsStruct: [ScoreForDestination]
    
    init(id: String, userNameString: String, nameScoresForDestination: [ScoreForDestination]) {
        self.id = id
        self.userNameString = userNameString
        self.nameScoresForDestinationsStruct = nameScoresForDestination
    }
}

struct ScoreForDestination: Decodable, Equatable {
    let id: String
    let destination: SortingDestination
    let score: String
    
    static func == (lhs: ScoreForDestination, rhs: ScoreForDestination) -> Bool {
        if lhs.destination == rhs.destination && lhs.score == rhs.score {
            return true
        } else {
            return false
        }
    }
}

class SortingQuestion: ObservableObject, Hashable {
    
    struct SortingQuestionChoice: Hashable {
        let id: String
        let choiceText: String
        let choiceImage: String?
        var choiceScoresForDestinationsDict: Dictionary<SortingDestination, String> {
            var dictionary = Dictionary<SortingDestination, String>()
            for choiceScore in self.choiceScoresForDestinationsStruct {
                dictionary[choiceScore.destination] = choiceScore.score
            }
            return dictionary
        }
        let choiceScoresForDestinationsStruct: [ScoreForDestination]
        
        init(id: String, choiceText: String, choiceScoresForDestinations: [ScoreForDestination]) {
            self.id = id
            self.choiceText = choiceText
            self.choiceScoresForDestinationsStruct = choiceScoresForDestinations
            self.choiceImage = nil
        }
        
        init(id: String, choiceText: String, choiceImage: String, choiceScoresForDestinations: [ScoreForDestination]) {
            self.id = id
            self.choiceText = choiceText
            self.choiceScoresForDestinationsStruct = choiceScoresForDestinations
            self.choiceImage = choiceImage
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(choiceText)
        }
        
        static func == (lhs: SortingQuestion.SortingQuestionChoice, rhs: SortingQuestion.SortingQuestionChoice) -> Bool {
            if lhs.choiceText == rhs.choiceText && lhs.choiceScoresForDestinationsStruct == rhs.choiceScoresForDestinationsStruct {
                return true
            } else {
                return false
            }
        }
    }
    
    @Published var id: String
    @Published var kidMode: Bool
    @Published var question: String
    @Published var choices: [SortingQuestionChoice]
    @Published var asked: Int
    
    init(id: String, question: String, choices: [SortingQuestionChoice]) {
        self.id = id
        self.question = question
        self.choices = choices
        self.asked = 0
        self.kidMode = false
    }
    
    init(id: String, kidMode: Bool, question: String, choices: [SortingQuestionChoice]) {
        self.id = id
        self.question = question
        self.choices = choices
        self.asked = 0
        self.kidMode = kidMode
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(question)
    }
    
    static func == (lhs: SortingQuestion, rhs: SortingQuestion) -> Bool {
        if lhs.question == rhs.question && lhs.choices == rhs.choices {
            return true
        } else {
            return false
        }
    }
    
    deinit {
        print("The question \(self.question) has been answered.")
    }
}

class SortingStore: ObservableObject {
    @Published var user = User("")
    @Published var questions = Dictionary<Int, SortingQuestion>()
    @Published var destinations = Dictionary<String, SortingDestination>()
    @Published var nameScores: [ScoreForName] = []
    @Published var questionCount = 0
    @Published var kidsMode = false
    @Published var questionsForSort = 5
    @Published var talkingHat = false
    @Published var mode: Mode = Mode.loading
    @Published var movie: AVPlayer?
    @Published var destination: SortingDestination?
    
    enum Mode {
        case loading
        case start
        case settings
        case sort
        case results
    }
    
    init() {
        print("A new Sorting Store has been initialized.")
    }
    
    func loadSortingStore(user: String) {
        self.user = User(user)
        self.user.sortingScores = Dictionary<SortingDestination, Int>()
        for destination in destinations.values {
            self.user.sortingScores![destination] = 0
        }
        for name in nameScores {
            if self.user.name.lowercased().contains(name.userNameString) {
                for destination in name.nameScoresForDestinationsDict.keys {
                    var score = 0
                    switch name.nameScoresForDestinationsDict[destination] {
                    case "destiny":
                        score = 5000
                    case "highest":
                        score = Int.random(in: 95...145)
                    case "higher":
                        score = Int.random(in: 55...105)
                    case "high":
                        score = Int.random(in: 15...65)
                    case "neutral":
                        score = Int.random(in: -25...25)
                    case "low":
                        score = Int.random(in: -65 ... -15)
                    case "lower":
                        score = Int.random(in: -105 ... -55)
                    case "lowest":
                        score = Int.random(in: -145 ... -95)
                    case "impossible":
                        score = -5000
                    default:
                        score = 0
                    }
                    print("Score for \(destination) \(name.nameScoresForDestinationsDict[destination] ?? "error - invalid destination") is \(score)")
                    self.user.sortingScores![destination] = score
                }
            }
        }
    }
    
    func questionScorer(user: User, question: SortingQuestion, choice: SortingQuestion.SortingQuestionChoice) {
        for destination in choice.choiceScoresForDestinationsDict.keys {
            var score = 0
            switch choice.choiceScoresForDestinationsDict[destination] {
            case "destiny":
                score = 5000
            case "highest":
                score = Int.random(in: 95...145)
            case "higher":
                score = Int.random(in: 55...105)
            case "high":
                score = Int.random(in: 15...65)
            case "neutral":
                score = Int.random(in: -25...25)
            case "low":
                score = Int.random(in: -65 ... -15)
            case "lower":
                score = Int.random(in: -105 ... -55)
            case "lowest":
                score = Int.random(in: -145 ... -95)
            case "impossible":
                score = -5000
            default:
                score = 0
            }
            print("Score for \(destination) \(choice.choiceScoresForDestinationsDict[destination] ?? "error - invalid destination") is \(score)")
            user.sortingScores![destination]! += score
        }
        question.asked = 1
        self.questionCount += 1
    }
    
    func resetStore() {
        self.user = User("")
        for question in questions.values {
            question.asked = 0
        }
        self.questionCount = 0
        self.mode = Mode.start
    }
    
    func sortingResult() {
        if self.user.sortingScores != nil {
        print("Sorting scores are: \(String(describing: self.user.sortingScores))")
            self.destination = self.user.sortingScores!.max(by: { a, b in a.value < b.value })?.key ?? SortingDestination(id: "error", name: "Error", descriptionFull: "The Sorting Hat needs to be fixed.")
        } else {
            self.destination = SortingDestination(id: "error", name: "Error", descriptionFull: "The Sorting Hat needs to be fixed.")
        }
        self.movie = AVPlayer(url: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(destination!.name).appendingPathExtension(".mov"))
    }
    
    deinit {
        print("The Sorting Store has been deinitialized.")
    }
}

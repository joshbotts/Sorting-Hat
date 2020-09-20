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
    let name: String
    let descriptionFull: String
    let description: String
    
    init(name: String, descriptionFull: String) {
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
    let userNameString: String
    var nameScoresForDestinationsDict: Dictionary<SortingDestination, Int> {
        var dictionary = Dictionary<SortingDestination, Int>()
        for nameScore in self.nameScoresForDestinationsStruct {
            dictionary[nameScore.destination] = nameScore.score
        }
        return dictionary
    }
    let nameScoresForDestinationsStruct: [ScoreForDestination]
    
    init(userNameString: String, nameScoresForDestination: [ScoreForDestination]) {
        self.userNameString = userNameString
        self.nameScoresForDestinationsStruct = nameScoresForDestination
    }
}

struct ScoreForDestination: Decodable, Equatable {
    var destination: SortingDestination
    var score: Int
    
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
        var choiceScoresForDestinationsDict: Dictionary<SortingDestination, Int> {
            var dictionary = Dictionary<SortingDestination, Int>()
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
    
    @Published var kidMode: Bool
    @Published var question: String
    @Published var choices: [SortingQuestionChoice]
    @Published var asked: Int
    
    init(question: String, choices: [SortingQuestionChoice]) {
        self.question = question
        self.choices = choices
        self.asked = 0
        self.kidMode = false
    }
    
    init(kidMode: Bool, question: String, choices: [SortingQuestionChoice]) {
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
    @Published var mode: Mode = Mode.start
    @Published var movie: AVPlayer?
    @Published var destination: SortingDestination?
    
    enum Mode {
        case start
        case settings
        case sort
        case results
    }
    
    init() {
        print("A new Sorting Store has been initialized.")
    }
    
    func loadSortingStore(user: User) {
        user.sortingScores = Dictionary<SortingDestination, Int>()
        for destination in destinations.values {
            user.sortingScores![destination] = 0
        }
        for name in nameScores {
            if user.name.lowercased().contains(name.userNameString) {
                for destination in name.nameScoresForDestinationsDict.keys {
                    user.sortingScores![destination] = name.nameScoresForDestinationsDict[destination]
                }
            }
        }
    }
    
    func questionScorer(user: User, question: SortingQuestion, choice: SortingQuestion.SortingQuestionChoice) {
        for destination in choice.choiceScoresForDestinationsDict.keys {
            user.sortingScores![destination]! += choice.choiceScoresForDestinationsDict[destination] ?? 0
        }
        question.asked = 1
        self.questionCount += 1
    }
    
    func resetStore() {
        self.user = User("")
        self.questions = Dictionary<Int, SortingQuestion>()
        self.destinations = Dictionary<String, SortingDestination>()
        self.nameScores = []
        self.questionCount = 0
        self.mode = Mode.start
    }
    
    func sortingResult() {
        if self.user.sortingScores != nil {
        print("Sorting scores are: \(String(describing: self.user.sortingScores))")
        self.destination = self.user.sortingScores!.max(by: { a, b in a.value < b.value })?.key ?? SortingDestination(name: "Error", descriptionFull: "The Sorting Hat needs to be fixed.")
        } else {
            self.destination = SortingDestination(name: "Error", descriptionFull: "The Sorting Hat needs to be fixed.")
        }
        self.movie = AVPlayer(url: Bundle.main.url(forResource: self.destination!.name, withExtension: "mov")!)
    }
    
    deinit {
        print("The Sorting Store has been deinitialized.")
    }
}

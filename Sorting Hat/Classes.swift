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
    
    init() {
        print("A new Sorting Store has been initialized.")
    }
    
    func setStore(user: String) {
        let highest: Int = Int.random(in: 2...4)
        let higher: Int = Int.random(in: 1...3)
        let high: Int = Int.random(in: 0...2)
        let neutral: Int = Int.random(in: -1...1)
        let low: Int = Int.random(in: -2...0)
        let lower: Int = Int.random(in: -3 ... -1)
        let lowest: Int = Int.random(in: -4 ... -2)
        
        //        func load<T: Decodable>(_ filename: String, as type: T.Type = T.self) -> T {
        //            let data: Data
        //
        //            guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        //                else {
        //                    fatalError("Couldn't find \(filename) in main bundle.")
        //            }
        //
        //            do {
        //                data = try Data(contentsOf: file)
        //            } catch {
        //                fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        //            }
        //
        //            do {
        //                let decoder = JSONDecoder()
        //                return try decoder.decode(T.self, from: data)
        //            } catch {
        //                fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        //            }
        //        }
        self.user = User(user)
        print("User \(user) has been added to the Sorting Store.")
        self.destinations = [
            "Gryffindor": SortingDestination(name: "Gryffindor", descriptionFull: "You might belong in Gryffindor,\nWhere dwell the brave at heart,\nTheir daring, nerve, and chivalry,\nSet Gryffindors apart"),
            "Ravenclaw": SortingDestination(name: "Ravenclaw", descriptionFull: "Or yet in wise old Ravenclaw,\nIf you've a ready mind,\nWhere those of wit and learning,\nWill always find their kind."),
            "Hufflepuff": SortingDestination(name: "Hufflepuff", descriptionFull: "You might belong in Hufflepuff,\nWhere they are just and loyal,\nThose patient Hufflepuffs are true,\nAnd unafraid of toil."),
            "Slytherin": SortingDestination(name: "Slytherin", descriptionFull: "Or perhaps in Slytherin,\nYou'll make your real friends,\nThose cunning folk use any means,\nTo achieve their ends."),
            "Ravenclaw Prefect": SortingDestination(name: "Ravenclaw Prefect", descriptionFull: "What would we want to be prefects for? It'd take all the fun out of life."),
            "Hogwarts Headmaster": SortingDestination(name: "Hogwarts Headmaster", descriptionFull: "Every headmaster and headmistress of Hogwarts has brought something new to the weighty task of governing this historic school, and that is as it should be, for without progress there will be stagnation and decay."),
            "Dumbledore's Army": SortingDestination(name: "Dumbledore's Army", descriptionFull: "Every great wizard in history has started out as nothing more than what we are now: students. If they can do it, why not us?"),
            "Dark Lord" : SortingDestination(name: "Dark Lord", descriptionFull: "That which Voldemort does not value, he takes no trouble to comprehend. Of house-elves and children's tales, of love, loyalty and innocence, Voldemort knows and understands nothing. Nothing. That they all have a power beyond his own, a power beyond the reach of any magic, is a truth that he has never grasped."),
            "Death Eater": SortingDestination(name: "Death Eater", descriptionFull: "They were a motley collection; a mixture of the weak seeking protection, the ambitious seeking some shared glory, and the thuggish gravitating toward a leader who could show them more refined forms of cruelty."),
            "Muggle": SortingDestination(name: "Muggle", descriptionFull: "Don’ listen properly, do they? Don’ look properly either. Never notice nuffink, they don’."),
            "Jedi": SortingDestination(name: "Jedi", descriptionFull: "There is no emotion, there is peace.\nThere is no ignorance, there is knowledge.\nThere is no passion, there is serenity.\nThere is no chaos, there is harmony.\nThere is no death, there is the Force."),
            "Sith": SortingDestination(name: "Sith", descriptionFull: "Peace is a lie. There is only passion.\nThrough passion I gain strength.\nThrough strength I gain power.\nThrough power I gain victory.\nThrough victory my chains are broken.\nThe Force shall free me.")
        ]
        print("Sorting Destinations have been loaded into the Sorting Store")
        self.nameScores = [
            ScoreForName(userNameString: "josh", nameScoresForDestination: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: low),
                ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: high),
                ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: high),
                ScoreForDestination(destination: self.destinations["Death Eater"]!, score: low),
                ScoreForDestination(destination: self.destinations["Muggle"]!, score: low),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: low)
            ]),
            ScoreForName(userNameString: "sara", nameScoresForDestination: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: low),
                ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: high),
                ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: high),
                ScoreForDestination(destination: self.destinations["Death Eater"]!, score: low),
                ScoreForDestination(destination: self.destinations["Muggle"]!, score: low),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: low),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: lower)
            ]),
            ScoreForName(userNameString: "grace", nameScoresForDestination: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: low),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: low),
                ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: high),
                ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Death Eater"]!, score: low),
                ScoreForDestination(destination: self.destinations["Muggle"]!, score: low),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: low)
            ]),
            ScoreForName(userNameString: "gracie", nameScoresForDestination: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: low),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: low),
                ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: high),
                ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Death Eater"]!, score: low),
                ScoreForDestination(destination: self.destinations["Muggle"]!, score: low),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: low)
            ]),
            ScoreForName(userNameString: "bolga", nameScoresForDestination: [
                ScoreForDestination(destination: self.destinations["Ravenclaw Prefect"]!, score: 15)
            ]),
            ScoreForName(userNameString: "renee", nameScoresForDestination: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: low),
                ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: high),
                ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: high),
                ScoreForDestination(destination: self.destinations["Death Eater"]!, score: low),
                ScoreForDestination(destination: self.destinations["Muggle"]!, score: low),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: low)
            ]),
            ScoreForName(userNameString: "renée", nameScoresForDestination: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: low),
                ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: high),
                ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: high),
                ScoreForDestination(destination: self.destinations["Death Eater"]!, score: low),
                ScoreForDestination(destination: self.destinations["Muggle"]!, score: low),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: low)
            ]),
            ScoreForName(userNameString: "joe", nameScoresForDestination: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: higher),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: low),
                ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: high),
                ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: high),
                ScoreForDestination(destination: self.destinations["Death Eater"]!, score: low),
                ScoreForDestination(destination: self.destinations["Muggle"]!, score: low),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: low)
            ]),
            ScoreForName(userNameString: "joseph", nameScoresForDestination: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: higher),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: low),
                ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: high),
                ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: high),
                ScoreForDestination(destination: self.destinations["Death Eater"]!, score: low),
                ScoreForDestination(destination: self.destinations["Muggle"]!, score: low),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: low)
            ]),
            ScoreForName(userNameString: "julia", nameScoresForDestination: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: low),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: low),
                ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: high),
                ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Death Eater"]!, score: low),
                ScoreForDestination(destination: self.destinations["Muggle"]!, score: low),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: low)
            ]),
            ScoreForName(userNameString: "molly", nameScoresForDestination: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: low),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: low),
                ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: high),
                ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Death Eater"]!, score: low),
                ScoreForDestination(destination: self.destinations["Muggle"]!, score: low),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: low)
            ]),
            ScoreForName(userNameString: "patti", nameScoresForDestination: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: low),
                ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: high),
                ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: high),
                ScoreForDestination(destination: self.destinations["Death Eater"]!, score: low),
                ScoreForDestination(destination: self.destinations["Muggle"]!, score: low),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: low)
            ]),
            ScoreForName(userNameString: "mandy", nameScoresForDestination: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: low),
                ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: high),
                ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: high),
                ScoreForDestination(destination: self.destinations["Death Eater"]!, score: low),
                ScoreForDestination(destination: self.destinations["Muggle"]!, score: low),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: higher),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
            ]),
            ScoreForName(userNameString: "eppy", nameScoresForDestination: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: low),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: high),
                ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: high),
                ScoreForDestination(destination: self.destinations["Death Eater"]!, score: high),
                ScoreForDestination(destination: self.destinations["Muggle"]!, score: higher),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: high)
            ]),
            ScoreForName(userNameString: "voldemort", nameScoresForDestination: [
                ScoreForDestination(destination: self.destinations["Dark Lord"]!, score: 20)
            ]),
            ScoreForName(userNameString: "dumbledore", nameScoresForDestination: [
                ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 20)
            ]),
            ScoreForName(userNameString: "potter", nameScoresForDestination: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 5),
                ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 5)
            ]),
            ScoreForName(userNameString: "longbottom", nameScoresForDestination: [
                ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 10)
            ])
            
        ]
        print("Name Scores have been added to the Sorting Store")
        self.questions = [
            1: SortingQuestion(question: "Which of these have you thought the most since the Sorting began?", choices: [
                SortingQuestion.SortingQuestionChoice(id: "not Slytherin", choiceText: "Not Slytherin, not Slytherin...", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: lower),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "miss Obama", choiceText: "I miss Obama.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: Int.random(in: 1...2)),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "kid's books", choiceText: "Harry Potter is for kids.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: high)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "hungry", choiceText: "I'm hungry.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ])
            ]),
            2: SortingQuestion(question: "Who is your favorite Beatle?", choices: [
                SortingQuestion.SortingQuestionChoice(id: "john", choiceText: "John Lennon", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: high)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "paul", choiceText: "Paul McCartney", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: high)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "george", choiceText: "George Harrison", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: high)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "ringo", choiceText: "Ringo Starr", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: high)
                ])
            ]),
            3: SortingQuestion(question: "What would you prefer to do during a quidditch game?", choices: [
                SortingQuestion.SortingQuestionChoice(id: "seeker", choiceText: "Be the Seeker!", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "chaser", choiceText: "Be a Chaser!", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "beater", choiceText: "Be a Beater!", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "keeper", choiceText: "Be the Keeper!", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "ref", choiceText: "Be the Referee!", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "fan", choiceText: "Be a spectator in the stands!", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: high)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "what", choiceText: "What's quidditch?", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: highest),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: higher)
                ])
            ]),
            4: SortingQuestion(question: "Which of these numbers is the most magical?", choices: [
                SortingQuestion.SortingQuestionChoice(id: "c", choiceText: "299,792,458", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: highest),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: highest)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "pi", choiceText: "3.14159", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "e", choiceText: "2.71828", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: high)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "seven", choiceText: "7", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "jenny", choiceText: "867-5309", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: highest),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: high)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "nine", choiceText: "IX", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: lower),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: lower),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: lower),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: lower),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: lower),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: lower),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: lower),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: highest),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: highest)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "42", choiceText: "42", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: high)
                ])
            ]),
            5: SortingQuestion(question: "Which of these drinks do you like best?", choices: [
                SortingQuestion.SortingQuestionChoice(id: "blue milk", choiceText: "Blue Milk", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: high)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "butter beer", choiceText: "Butter Beer", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "coffee", choiceText: "Coffee", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: highest),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "fire whiskey", choiceText: "Fire Whiskey", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "enemy tears", choiceText: "The tears of my enemies", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: lower),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: lower),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: lower),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: lower),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: lower),ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: highest),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: lower),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: highest)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "nagini milk", choiceText: "The milk of Nagini", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: lower),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: lower),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: lower),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: lower),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: lower),ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: highest),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: lower),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "apple juice", choiceText: "Apple Juice", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "tea", choiceText: "Tea. Earl Grey. Hot.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ])
            ]),
            6: SortingQuestion(question: "Which of these would you prefer as your wand core?", choices: [
                SortingQuestion.SortingQuestionChoice(id: "phoenix feather", choiceText: "A phoenix feather", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "unicorn hair", choiceText: "A unicorn hair", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "malabrigo", choiceText: "Malabrigo wool", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "kyber crystal", choiceText: "A kyber crystal", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: highest),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: highest)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "dragon heartstring", choiceText: "Dragon heartstring", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "apple A14X", choiceText: "An A14X cpu", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: highest),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "plutonium", choiceText: "Plutonium", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: higher)
                ])
            ]),
            7: SortingQuestion(question: "How many spaces should be used after a period ending a sentence?", choices: [
                SortingQuestion.SortingQuestionChoice(id: "1", choiceText: "Just one. This is the 21st century.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: high)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "2", choiceText: "Two.  That's how I was raised.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "anarchy", choiceText: "gRAmmaR-iS/faSCist*mAk3_Y0ur,0wN|rU1ez", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: higher)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "proust", choiceText: "Why should a sentence ever end when my thoughts meander like so much...", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "whatever", choiceText: "Whatever MS Word tells me, I do.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ])
            ]),
            8: SortingQuestion(question: "Red pizza or white pizza?", choices: [
                SortingQuestion.SortingQuestionChoice(id: "red", choiceText: "Red. What are we even talking about?", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: high)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "white", choiceText: "White. Don't you care about authenticity?", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "more", choiceText: "Whatever, just bring more.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ])
            ]),
            9: SortingQuestion(question: "Which of these is your favorite screen?", choices: [
                SortingQuestion.SortingQuestionChoice(id: "phone", choiceText: "My phone. It's always with me.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: high)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "tablet", choiceText: "My tablet. It's perfect for downtime.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "smoke", choiceText: "Smoke. Keep 'em guessing.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: higher)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "silk", choiceText: "Silk. My t-shirts are 😎", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "desktop monitor", choiceText: "My work computer monitor. I'm kind of a big deal.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: high)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "tv", choiceText: "My television. And get off my lawn.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ])
            ]),
            10: SortingQuestion(question: "What is your favorite season of The Wire?", choices: [
                SortingQuestion.SortingQuestionChoice(id: "1", choiceText: "First season. Where's Wallace?", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: high)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "2", choiceText: "Second season. The docks.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "3", choiceText: "Third season. Hamsterdam.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: higher)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "4", choiceText: "Fourth season. Those kids.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "5", choiceText: "Fifth season. Stop me, before I kill again.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: high)
                ])
            ]),
            11: SortingQuestion(question: "Which of these pies do you prefer?", choices: [
                SortingQuestion.SortingQuestionChoice(id: "apple", choiceText: "Apple.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "pi", choiceText: "π", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: high)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "rhubarb", choiceText: "Rhubarb", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "strawberry rhubarb", choiceText: "Strawberry rhubarb", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: higher)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "sweetie", choiceText: "Sweetie.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "cherry", choiceText: "Cherry", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "american", choiceText: "American (Bye Bye)", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ])
            ]),
            12: SortingQuestion(question: "Wand, stone, or cloak?", choices: [
                SortingQuestion.SortingQuestionChoice(id: "wand", choiceText: "Once won, the wand would serve me best.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: high)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "stone", choiceText: "With the stone, I could face even my greatest fears.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "cloak", choiceText: "With the cloak, I can escape from danger.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "what", choiceText: "What are you talking about?", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: lower),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: higher)
                ])
            ]),
            13: SortingQuestion(question: "You stand alone against the forces of evil. What spell do you cast?", choices: [
                SortingQuestion.SortingQuestionChoice(id: "imperio", choiceText: "Imperio!", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: highest),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: higher)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "expelliarmus", choiceText: "Expelliarmus!", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "patronus", choiceText: "Expecto patronum!", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "protego", choiceText: "Protego!", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: lower),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: low)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "apparate", choiceText: "Sorry. Gotta apparate out of here.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: lower),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: lower),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: lower),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: high)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "morsmordre", choiceText: "Morsmordre!", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: lower),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: lower),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: lower),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: lower),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: lower),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: highest),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: higher)
                ])
            ]),
            14: SortingQuestion(question: "Which of these vacations would you prefer?", choices: [
                SortingQuestion.SortingQuestionChoice(id: "beach", choiceText: "Take me to the beach!", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: high)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "hike", choiceText: "Let's go on spectacular hike!", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "staycation", choiceText: "I'm going to stay home with a pile of books!", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "tatooine", choiceText: "I don't care as long as we stop on Tatooine to pick up some power converters.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: higher)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "disney", choiceText: "I'm going to Disney World!", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "travel", choiceText: "I don't care as long as we go somewhere I've never been before.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: high)
                ])
            ]),
            15: SortingQuestion(question: "Which class do you prefer?", choices: [
                SortingQuestion.SortingQuestionChoice(id: "history", choiceText: "History", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: high)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "math", choiceText: "Math", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: high)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "Science", choiceText: "Science", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: higher)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "yoga", choiceText: "Yoga", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: high)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "music", choiceText: "Music", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "english", choiceText: "English", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "foreign language", choiceText: "Foreign Language", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "art", choiceText: "Art", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "gym", choiceText: "Gym", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: high)
                ])
            ]),
            16: SortingQuestion(question: "Who is your favorite Weasley?", choices: [
                SortingQuestion.SortingQuestionChoice(id: "molly", choiceText: "Molly.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "arthur", choiceText: "Arthur.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "bill", choiceText: "Bill.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "charlie", choiceText: "Charlie.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "percy", choiceText: "Percy.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: high)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "george", choiceText: "George.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "fred", choiceText: "Fred.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "ron", choiceText: "Ron.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "ginny", choiceText: "Ginny.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ])
            ]),
            17: SortingQuestion(question: "What would you be most likely to see in the Mirror of Erised?", choices: [
                SortingQuestion.SortingQuestionChoice(id: "socks", choiceText: "Thick, wool socks.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: highest),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "balance", choiceText: "A balance, and some faded texts from a galaxy far, far away.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: highest),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "hp8", choiceText: "An eighth Harry Potter book. And not that Cursed Child nonsense.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "family", choiceText: "Myself and my family, a little older, a little happier, and surrounded by all of our friends.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "kushner", choiceText: "Jared Kushner, giving me a high five.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: higher)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "myself", choiceText: "Myself, just as I am.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "rhubarb", choiceText: "Piles and piles of rhubarb.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: low)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "money", choiceText: "A vault chock full of money, ready for me to dive in like Scrooge McDuck.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ])
            ]),
            18: SortingQuestion(question: "Which is the most powerful?", choices: [
                SortingQuestion.SortingQuestionChoice(id: "magic", choiceText: "Magic. Who knows if it even has limits?", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "knowledge", choiceText: "Knowledge. It unlocks everything else.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "music", choiceText: "Music. It makes your body move and your soul soar.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "love", choiceText: "Love. It's all you need.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: low)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "power", choiceText: "Power. I mean, it's right there in the word.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: higher)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "money", choiceText: "Money. That's what I want.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ])
            ]),
            19: SortingQuestion(question: "When is it ok to lie?", choices: [
                SortingQuestion.SortingQuestionChoice(id: "never", choiceText: "Never.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "greater good", choiceText: "When it contributes to the greater good.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "liar", choiceText: "Whenever I want.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: higher)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "help", choiceText: "When it helps a friend.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "point of view", choiceText: "It depends greatly on your point of view.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: highest),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: high)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "tuesdays", choiceText: "On Tuesdays.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ])
            ]),
            20: SortingQuestion(question: "What is your favorite Harry Potter book?", choices: [
                SortingQuestion.SortingQuestionChoice(id: "stone", choiceText: "Sorcerer's Stone.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "chamber", choiceText: "Chamber of Secrets.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "prisoner", choiceText: "Prisoner of Azkaban.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: highest),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "goblet", choiceText: "Goblet of Fire.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "order", choiceText: "Order of the Phoenix.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score:  neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: highest),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "prince", choiceText: "Half-Blood Prince.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: highest),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "hallows", choiceText: "Deathly Hallows.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "child", choiceText: "Cursed Child.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "none", choiceText: "None of them are any good.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: lowest),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: lower),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: highest),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: higher)
                ])
            ])
        ]
        print("Questions have been loaded into the Sorting Store")
        self.loadSortingStore(user: self.user)
        print("Scores for destinations have been set for \(user)")
    }
    
    func setKidStore(user: String) {
        let highest: Int = Int.random(in: 2...4)
        let higher: Int = Int.random(in: 1...3)
        let high: Int = Int.random(in: 0...2)
        let neutral: Int = Int.random(in: -1...1)
        let low: Int = Int.random(in: -2...0)
        let lower: Int = Int.random(in: -3 ... -1)
        let lowest: Int = Int.random(in: -4 ... -2)
        
    //        func load<T: Decodable>(_ filename: String, as type: T.Type = T.self) -> T {
    //            let data: Data
    //
    //            guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    //                else {
    //                    fatalError("Couldn't find \(filename) in main bundle.")
    //            }
    //
    //            do {
    //                data = try Data(contentsOf: file)
    //            } catch {
    //                fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    //            }
    //
    //            do {
    //                let decoder = JSONDecoder()
    //                return try decoder.decode(T.self, from: data)
    //            } catch {
    //                fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    //            }
    //        }
    self.user = User(user)
    print("User \(user) has been added to the Sorting Store.")
    self.destinations = [
        "Gryffindor": SortingDestination(name: "Gryffindor", descriptionFull: "You might belong in Gryffindor,\nWhere dwell the brave at heart,\nTheir daring, nerve, and chivalry,\nSet Gryffindors apart"),
        "Ravenclaw": SortingDestination(name: "Ravenclaw", descriptionFull: "Or yet in wise old Ravenclaw,\nIf you've a ready mind,\nWhere those of wit and learning,\nWill always find their kind."),
        "Hufflepuff": SortingDestination(name: "Hufflepuff", descriptionFull: "You might belong in Hufflepuff,\nWhere they are just and loyal,\nThose patient Hufflepuffs are true,\nAnd unafraid of toil."),
        "Slytherin": SortingDestination(name: "Slytherin", descriptionFull: "Or perhaps in Slytherin,\nYou'll make your real friends,\nThose cunning folk use any means,\nTo achieve their ends."),
        "Ravenclaw Prefect": SortingDestination(name: "Ravenclaw Prefect", descriptionFull: "What would we want to be prefects for? It'd take all the fun out of life."),
        "Dark Lord" : SortingDestination(name: "Dark Lord", descriptionFull: "That which Voldemort does not value, he takes no trouble to comprehend. Of house-elves and children's tales, of love, loyalty and innocence, Voldemort knows and understands nothing. Nothing. That they all have a power beyond his own, a power beyond the reach of any magic, is a truth that he has never grasped."),
        "Jedi": SortingDestination(name: "Jedi", descriptionFull: "There is no emotion, there is peace.\nThere is no ignorance, there is knowledge.\nThere is no passion, there is serenity.\nThere is no chaos, there is harmony.\nThere is no death, there is the Force."),
        "Sith": SortingDestination(name: "Sith", descriptionFull: "Peace is a lie. There is only passion.\nThrough passion I gain strength.\nThrough strength I gain power.\nThrough power I gain victory.\nThrough victory my chains are broken.\nThe Force shall free me.")
    ]
    print("Sorting Destinations have been loaded into the Sorting Store")
    self.nameScores = [
        ScoreForName(userNameString: "josh", nameScoresForDestination: [
            ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
            ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
            ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
            ScoreForDestination(destination: self.destinations["Slytherin"]!, score: low),
            ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
            ScoreForDestination(destination: self.destinations["Sith"]!, score: low)
        ]),
        ScoreForName(userNameString: "sara", nameScoresForDestination: [
            ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
            ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
            ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
            ScoreForDestination(destination: self.destinations["Slytherin"]!, score: low),
            ScoreForDestination(destination: self.destinations["Jedi"]!, score: low),
            ScoreForDestination(destination: self.destinations["Sith"]!, score: lower)
        ]),
        ScoreForName(userNameString: "grace", nameScoresForDestination: [
            ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
            ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
            ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: low),
            ScoreForDestination(destination: self.destinations["Slytherin"]!, score: low),
            ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
            ScoreForDestination(destination: self.destinations["Sith"]!, score: lowest)
        ]),
        ScoreForName(userNameString: "gracie", nameScoresForDestination: [
            ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
            ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
            ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: low),
            ScoreForDestination(destination: self.destinations["Slytherin"]!, score: low),
            ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
            ScoreForDestination(destination: self.destinations["Sith"]!, score: lowest)
        ]),
        ScoreForName(userNameString: "bolga", nameScoresForDestination: [
            ScoreForDestination(destination: self.destinations["Ravenclaw Prefect"]!, score: 15)
        ]),
        ScoreForName(userNameString: "renee", nameScoresForDestination: [
            ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
            ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
            ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
            ScoreForDestination(destination: self.destinations["Slytherin"]!, score: low),
            ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
            ScoreForDestination(destination: self.destinations["Sith"]!, score: low)
        ]),
        ScoreForName(userNameString: "renée", nameScoresForDestination: [
            ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
            ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
            ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
            ScoreForDestination(destination: self.destinations["Slytherin"]!, score: low),
            ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
            ScoreForDestination(destination: self.destinations["Sith"]!, score: low)
        ]),
        ScoreForName(userNameString: "joe", nameScoresForDestination: [
            ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
            ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: higher),
            ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
            ScoreForDestination(destination: self.destinations["Slytherin"]!, score: low),
            ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
            ScoreForDestination(destination: self.destinations["Sith"]!, score: low)
        ]),
        ScoreForName(userNameString: "joseph", nameScoresForDestination: [
            ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
            ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: higher),
            ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
            ScoreForDestination(destination: self.destinations["Slytherin"]!, score: low),
            ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
            ScoreForDestination(destination: self.destinations["Sith"]!, score: low)
        ]),
        ScoreForName(userNameString: "julia", nameScoresForDestination: [
            ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
            ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
            ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: low),
            ScoreForDestination(destination: self.destinations["Slytherin"]!, score: low),
            ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
            ScoreForDestination(destination: self.destinations["Sith"]!, score: low)
        ]),
        ScoreForName(userNameString: "molly", nameScoresForDestination: [
            ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
            ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
            ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: low),
            ScoreForDestination(destination: self.destinations["Slytherin"]!, score: low),
            ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
            ScoreForDestination(destination: self.destinations["Sith"]!, score: low)
        ]),
        ScoreForName(userNameString: "patti", nameScoresForDestination: [
            ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
            ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
            ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
            ScoreForDestination(destination: self.destinations["Slytherin"]!, score: low),
            ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
            ScoreForDestination(destination: self.destinations["Sith"]!, score: low)
        ]),
        ScoreForName(userNameString: "mandy", nameScoresForDestination: [
            ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
            ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
            ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
            ScoreForDestination(destination: self.destinations["Slytherin"]!, score: low),
            ScoreForDestination(destination: self.destinations["Jedi"]!, score: higher),
            ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
        ]),
        ScoreForName(userNameString: "eppy", nameScoresForDestination: [
            ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
            ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: low),
            ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
            ScoreForDestination(destination: self.destinations["Slytherin"]!, score: high),
            ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
            ScoreForDestination(destination: self.destinations["Sith"]!, score: high)
        ]),
        ScoreForName(userNameString: "voldemort", nameScoresForDestination: [
            ScoreForDestination(destination: self.destinations["Dark Lord"]!, score: 20)
        ]),
        ScoreForName(userNameString: "potter", nameScoresForDestination: [
            ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 5)
        ])
    ]
    print("Name Scores have been added to the Sorting Store")
    self.questions = [
        1: SortingQuestion(kidMode: true, question: "Which of these Frozen characters do you like best?", choices: [
            SortingQuestion.SortingQuestionChoice(id: "elsa", choiceText: "elsa", choiceImage: "elsa", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "anna", choiceText: "anna", choiceImage: "anna", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "olaf", choiceText: "olaf", choiceImage: "olaf", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "kristoff", choiceText: "kristoff", choiceImage: "kristoff", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
            ])
        ]),
        2: SortingQuestion(kidMode: true, question: "Which of these Star Wars characters do you like best?", choices: [
            SortingQuestion.SortingQuestionChoice(id: "r2d2", choiceText: "r2d2", choiceImage: "r2d2", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: highest),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: lowest)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "ahsoka", choiceText: "ahsoka", choiceImage: "ahsoka", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: highest),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: lowest)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "boba fett", choiceText: "boba fett", choiceImage: "boba fett", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: lowest),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: highest)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "darth vader", choiceText: "darth vader", choiceImage: "darth vader", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: lowest),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: highest)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "luke", choiceText: "luke", choiceImage: "luke", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: highest),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: lowest)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "han solo", choiceText: "han solo", choiceImage: "han solo", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: highest),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: lowest)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "leia", choiceText: "leia", choiceImage: "leia", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: highest),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: lowest)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "yoda", choiceText: "yoda", choiceImage: "yoda", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: highest),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: lowest)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "lando calrissian", choiceText: "lando calrissian", choiceImage: "lando calrissian", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: highest),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: lowest)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "chewie", choiceText: "chewie", choiceImage: "chewie", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: highest),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: lowest)
            ])
        ]),
        3: SortingQuestion(kidMode: true, question: "Which of these Winnie the Pooh characters do you like best?", choices: [
            SortingQuestion.SortingQuestionChoice(id: "pooh", choiceText: "pooh", choiceImage: "pooh", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: highest),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "piglet", choiceText: "piglet", choiceImage: "piglet", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: highest),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "tigger", choiceText: "tigger", choiceImage: "tigger", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: highest),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "eeyore", choiceText: "eeyore", choiceImage: "eeyore", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: highest),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "rabbit", choiceText: "rabbit", choiceImage: "rabbit", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: highest),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
            ])
        ]),
        4: SortingQuestion(kidMode: true, question: "Which of these Harry Potter characters do you like best?", choices: [
            SortingQuestion.SortingQuestionChoice(id: "harry", choiceText: "harry", choiceImage: "harry", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: highest),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "ron", choiceText: "ron", choiceImage: "ron", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: highest),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "hermione", choiceText: "hermione", choiceImage: "hermione", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: highest),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
            ])
        ]),
        5: SortingQuestion(kidMode: true, question: "Which of these dinosaurs do you like best?", choices: [
            SortingQuestion.SortingQuestionChoice(id: "maiasaurus", choiceText: "maiasaurus", choiceImage: "maiasaurus", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "struthiomimus", choiceText: "struthiomimus", choiceImage: "struthiomimus", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "stegosaurus", choiceText: "stegosaurus", choiceImage: "stegosaurus", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "triceratops", choiceText: "triceratops", choiceImage: "triceratops", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "troodon", choiceText: "troodon", choiceImage: "troodon", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "tyrannosaurus", choiceText: "tyrannosaurus", choiceImage: "tyrannosaurus", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "velociraptor", choiceText: "velociraptor", choiceImage: "velociraptor", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
            ])
        ]),
        6: SortingQuestion(kidMode: true, question: "Which of these spaceships do you like best?", choices: [
            SortingQuestion.SortingQuestionChoice(id: "apollo", choiceText: "apollo", choiceImage: "apollo", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "enterprise", choiceText: "enterprise", choiceImage: "enterprise", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "lego", choiceText: "lego", choiceImage: "lego", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "millennium falcon", choiceText: "millennium falcon", choiceImage: "millennium falcon", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: higher),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "space shuttle", choiceText: "space shuttle", choiceImage: "space shuttle", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
            ])
        ]),
        7: SortingQuestion(kidMode: true, question: "Which of these animals do you like best?", choices: [
            SortingQuestion.SortingQuestionChoice(id: "badger", choiceText: "badger", choiceImage: "badger", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: low),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: low),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: highest),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: low),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "eagle", choiceText: "eagle", choiceImage: "eagle", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: low),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: highest),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: low),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: low),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "lion", choiceText: "lion", choiceImage: "lion", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: highest),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: low),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: low),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: low),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "snake", choiceText: "snake", choiceImage: "snake", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: low),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: low),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: low),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: highest),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
            ])
        ]),
        8: SortingQuestion(kidMode: true, question: "Which of these birds do you like best?", choices: [
            SortingQuestion.SortingQuestionChoice(id: "bald eagle", choiceText: "bald eagle", choiceImage: "bald eagle", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "owl", choiceText: "owl", choiceImage: "owl", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "penguins", choiceText: "penguins", choiceImage: "penguins", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "pelican", choiceText: "pelican", choiceImage: "pelican", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
            ])
        ]),
        9: SortingQuestion(kidMode: true, question: "Which of these books do you like best?", choices: [
            SortingQuestion.SortingQuestionChoice(id: "seuss", choiceText: "seuss", choiceImage: "seuss", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "elephant and piggie", choiceText: "elephant and piggie", choiceImage: "elephant and piggie", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "pooh book", choiceText: "pooh book", choiceImage: "pooh book", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "harry potter", choiceText: "harry potter", choiceImage: "harry potter", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: higher),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: higher),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: higher),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: higher),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "charlie and the chocolate factory", choiceText: "charlie and the chocolate factory", choiceImage: "charlie and the chocolate factory", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "phantom tollbooth", choiceText: "phantom tollbooth", choiceImage: "phantom tollbooth", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
            ])
        ]),
        10: SortingQuestion(kidMode: true, question: "Which of these PJ Mask characters do you like best?", choices: [
            SortingQuestion.SortingQuestionChoice(id: "gekko", choiceText: "gekko", choiceImage: "gekko", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "owlette", choiceText: "owlette", choiceImage: "owlette", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "night ninja", choiceText: "night ninja", choiceImage: "night ninja", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "catboy", choiceText: "catboy", choiceImage: "catboy", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "romeo", choiceText: "romeo", choiceImage: "romeo", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "luna girl", choiceText: "luna girl", choiceImage: "luna girl", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
            ])
        ]),
    11: SortingQuestion(kidMode: true, question: "Which of these Star Wars characters do you best?", choices: [
            SortingQuestion.SortingQuestionChoice(id: "bb8", choiceText: "bb8", choiceImage: "bb8", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: higher),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: lower)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "kylo ren", choiceText: "kylo ren", choiceImage: "kylo ren", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: lower),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: higher)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "rey", choiceText: "rey", choiceImage: "rey", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: higher),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: lower)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "finn", choiceText: "finn", choiceImage: "finn", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: higher),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: lower)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "poe dameron", choiceText: "poe dameron", choiceImage: "poe dameron", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: higher),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: lower)
            ])
        ]),
        12: SortingQuestion(kidMode: true, question: "Which of these Star Wars characters do you like best?", choices: [
                SortingQuestion.SortingQuestionChoice(id: "palpatine", choiceText: "palpatine", choiceImage: "palpatine", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: lower),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: higher)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "anakin", choiceText: "anakin", choiceImage: "anakin", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: lower)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "padme", choiceText: "padme", choiceImage: "padme", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: lower)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "obiwan", choiceText: "obiwan", choiceImage: "obiwan", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: lower)
                ])
            ]),
            13: SortingQuestion(kidMode: true, question: "Which of these Baby Yoda pictures is the cutest?", choices: [
                    SortingQuestion.SortingQuestionChoice(id: "baby yoda", choiceText: "baby yoda", choiceImage: "baby yoda", choiceScoresForDestinations: [
                        ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Jedi"]!, score: higher),
                        ScoreForDestination(destination: self.destinations["Sith"]!, score: lower)
                    ]),
                    SortingQuestion.SortingQuestionChoice(id: "baby yoda 2", choiceText: "baby yoda 2", choiceImage: "baby yoda 2", choiceScoresForDestinations: [
                        ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Jedi"]!, score: higher),
                        ScoreForDestination(destination: self.destinations["Sith"]!, score: lower)
                    ]),
                    SortingQuestion.SortingQuestionChoice(id: "baby yoda 3", choiceText: "baby yoda 3", choiceImage: "baby yoda 3", choiceScoresForDestinations: [
                        ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Jedi"]!, score: higher),
                        ScoreForDestination(destination: self.destinations["Sith"]!, score: lower)
                    ])
                ]),
                14: SortingQuestion(kidMode: true, question: "Which of these Hogwarts professors do you like best?", choices: [
                    SortingQuestion.SortingQuestionChoice(id: "hagrid", choiceText: "hagrid", choiceImage: "hagrid", choiceScoresForDestinations: [
                        ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: higher),
                        ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                    ]),
                    SortingQuestion.SortingQuestionChoice(id: "dumbledore", choiceText: "dumbledore", choiceImage: "dumbledore", choiceScoresForDestinations: [
                        ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: higher),
                        ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                    ]),
                    SortingQuestion.SortingQuestionChoice(id: "mcgonagall", choiceText: "mcgonagall", choiceImage: "mcgonagall", choiceScoresForDestinations: [
                        ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: higher),
                        ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                    ]),
                    SortingQuestion.SortingQuestionChoice(id: "snape", choiceText: "snape", choiceImage: "snape", choiceScoresForDestinations: [
                        ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Slytherin"]!, score: higher),
                        ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                    ])
                ]),
                15: SortingQuestion(kidMode: true, question: "Which of these shows do you like best?", choices: [
                    SortingQuestion.SortingQuestionChoice(id: "xavier riddle", choiceText: "xavier riddle", choiceImage: "xavier riddle", choiceScoresForDestinations: [
                        ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                    ]),
                    SortingQuestion.SortingQuestionChoice(id: "dinosaur train", choiceText: "dinosaur train", choiceImage: "dinosaur train", choiceScoresForDestinations: [
                        ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                    ]),
                    SortingQuestion.SortingQuestionChoice(id: "daniel tiger", choiceText: "daniel tiger", choiceImage: "daniel tiger", choiceScoresForDestinations: [
                        ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                    ]),
                    SortingQuestion.SortingQuestionChoice(id: "molly of denali", choiceText: "molly of denali", choiceImage: "molly of denali", choiceScoresForDestinations: [
                        ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                    ])
                ]),
                16: SortingQuestion(kidMode: true, question: "Rock, paper, or scissors??", choices: [
                    SortingQuestion.SortingQuestionChoice(id: "rock", choiceText: "rock", choiceImage: "rock", choiceScoresForDestinations: [
                        ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                    ]),
                    SortingQuestion.SortingQuestionChoice(id: "paper", choiceText: "paper", choiceImage: "paper", choiceScoresForDestinations: [
                        ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                    ]),
                    SortingQuestion.SortingQuestionChoice(id: "scissors", choiceText: "scissors", choiceImage: "scissors", choiceScoresForDestinations: [
                        ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                        ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                    ])
                ])
        ]
        print("Kid questions have been loaded into the Sorting Store")
            self.loadSortingStore(user: self.user)
            print("Scores for destinations have been set for \(user)")
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
    }
    
    func resetStore() {
        self.user = User("")
        self.questions = Dictionary<Int, SortingQuestion>()
        self.destinations = Dictionary<String, SortingDestination>()
        self.nameScores = []
    }
    
    deinit {
        print("The Sorting Store has been deinitialized.")
    }
}

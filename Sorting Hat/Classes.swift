//
//  Classes.swift
//  Sorting Hat
//
//  Created by Joshua Botts on 4/15/20.
//  Copyright © 2020 Joshua Botts. All rights reserved.
//

import Foundation

struct SortingDestination: Decodable, Hashable, Equatable {
    let name: String
    let description: String
    
    init(name: String, description: String) {
        self.name = name
        self.description = description
    }
    
    static func == (lhs: SortingDestination, rhs: SortingDestination) -> Bool {
        if lhs.name == rhs.name && lhs.description == rhs.description {
            return true
        } else {
            return false
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(description)
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

//class SortingQuestionChoice: ObservableObject, Decodable {
//    @Published var id: String
//    @Published var choiceText: String
//    @Published var choiceScoresForDestinations: Dictionary<SortingDestination, Int>
//
//    init(id: String, choiceText: String, choiceScoresForDestinations: Dictionary<SortingDestination, Int>) {
//        self.id = id
//        self.choiceText = choiceText
//        self.choiceScoresForDestinations = choiceScoresForDestinations
//    }
//
//    required init(from: Decoder) throws {
//
//    }
//}

struct ScoreForDestination: Decodable {
    var destination: SortingDestination
    var score: Int
}

class SortingQuestion: ObservableObject {
    
    struct SortingQuestionChoice {
        let id: String
        let choiceText: String
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
        }
        
//        required init(from: Decoder) throws {
//            self.id = try? JSONDecoder().decode(<#T##type: Decodable.Protocol##Decodable.Protocol#>, from: <#T##Data#>)
//            self.choiceText = try? JSONDecoder().decode(<#T##type: Decodable.Protocol##Decodable.Protocol#>, from: <#T##Data#>)
//            self.choiceScoresForDestinations = try? JSONDecoder().decode(<#T##type: Decodable.Protocol##Decodable.Protocol#>, from: <#T##Data#>)
//        }
    }
    
    @Published var question: String
    @Published var choices: [SortingQuestionChoice]
    @Published var asked: Int
    
    init(question: String, choices: [SortingQuestionChoice]) {
        self.question = question
        self.choices = choices
        self.asked = 0
    }
    
//    required init(from: Decoder) throws {
//
//    }
    
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
            "Gryffindor": SortingDestination(name: "Gryffindor", description: "You might belong in Gryffindor,\nWhere dwell the brave at heart,\nTheir daring, nerve, and chivalry,\nSet Gryffindors apart"),
            "Ravenclaw": SortingDestination(name: "Ravenclaw", description: "Or yet in wise old Ravenclaw,\nIf you've a ready mind,\nWhere those of wit and learning,\nWill always find their kind."),
            "Hufflepuff": SortingDestination(name: "Hufflepuff", description: "You might belong in Hufflepuff,\nWhere they are just and loyal,\nThose patient Hufflepuffs are true,\nAnd unafraid of toil."),
            "Slytherin": SortingDestination(name: "Slytherin", description: "Or perhaps in Slytherin,\nYou'll make your real friends,\nThose cunning folk use any means,\nTo achieve their ends."),
            "Hogwart's Headmaster": SortingDestination(name: "Hogwart's Headmaster", description: "Every headmaster and headmistress of Hogwarts has brought something new to the weighty task of governing this historic school, and that is as it should be, for without progress there will be stagnation and decay."),
            "Dumbledore's Army": SortingDestination(name: "Dumbledore's Army", description: "Every great wizard in history has started out as nothing more than what we are now: students. If they can do it, why not us?"),
            "Death Eater": SortingDestination(name: "Death Eater", description: "They were a motley collection; a mixture of the weak seeking protection, the ambitious seeking some shared glory, and the thuggish gravitating toward a leader who could show them more refined forms of cruelty."),
            "Muggle": SortingDestination(name: "Muggle", description: "Don’ listen properly, do they? Don’ look properly either. Never notice nuffink, they don’."),
            "Jedi": SortingDestination(name: "Jedi", description: "There is no emotion, there is peace.\nThere is no ignorance, there is knowledge.\nThere is no passion, there is serenity.\nThere is no chaos, there is harmony.\nThere is no death, there is the Force."),
            "Sith": SortingDestination(name: "Sith", description: "Peace is a lie. There is only passion.\nThrough passion I gain strength.\nThrough strength I gain power.\nThrough power I gain victory.\nThrough victory my chains are broken.\nThe Force shall free me.")
        ]
        print("Sorting Destinations have been loaded into the Sorting Store")
        self.nameScores = [
            ScoreForName(userNameString: "josh", nameScoresForDestination: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 1),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 1),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: -1),
                ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 1),
                ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 1),
                ScoreForDestination(destination: self.destinations["Death Eater"]!, score: -1),
                ScoreForDestination(destination: self.destinations["Muggle"]!, score: -1),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: 1),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: -1)
            ]),
        ScoreForName(userNameString: "sara", nameScoresForDestination: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 1),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 1),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 1),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: -1),
                ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 1),
                ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 1),
                ScoreForDestination(destination: self.destinations["Death Eater"]!, score: -1),
                ScoreForDestination(destination: self.destinations["Muggle"]!, score: -1),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: -1),
        ScoreForDestination(destination: self.destinations["Sith"]!, score: -2)
        ]),
        ScoreForName(userNameString: "grace", nameScoresForDestination: [
        ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 1),
        ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 1),
        ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: -1),
        ScoreForDestination(destination: self.destinations["Slytherin"]!, score: -1),
        ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 1),
        ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
        ScoreForDestination(destination: self.destinations["Death Eater"]!, score: -1),
        ScoreForDestination(destination: self.destinations["Muggle"]!, score: -1),
        ScoreForDestination(destination: self.destinations["Jedi"]!, score: 1),
        ScoreForDestination(destination: self.destinations["Sith"]!, score: -1)
        ]),
        ScoreForName(userNameString: "gracie", nameScoresForDestination: [
        ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 1),
        ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 1),
        ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: -1),
        ScoreForDestination(destination: self.destinations["Slytherin"]!, score: -1),
        ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 1),
        ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
        ScoreForDestination(destination: self.destinations["Death Eater"]!, score: -1),
        ScoreForDestination(destination: self.destinations["Muggle"]!, score: -1),
        ScoreForDestination(destination: self.destinations["Jedi"]!, score: 1),
        ScoreForDestination(destination: self.destinations["Sith"]!, score: -1)
        ]),
        ScoreForName(userNameString: "bolga", nameScoresForDestination: [
        ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
        ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 2),
        ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 0),
        ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 0),
        ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 2),
        ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
        ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
        ScoreForDestination(destination: self.destinations["Muggle"]!, score: 0),
        ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
        ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
        ]),
        ScoreForName(userNameString: "renee", nameScoresForDestination: [
        ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 1),
        ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 1),
        ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 1),
        ScoreForDestination(destination: self.destinations["Slytherin"]!, score: -1),
        ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 1),
        ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 1),
        ScoreForDestination(destination: self.destinations["Death Eater"]!, score: -1),
        ScoreForDestination(destination: self.destinations["Muggle"]!, score: -1),
        ScoreForDestination(destination: self.destinations["Jedi"]!, score: 1),
        ScoreForDestination(destination: self.destinations["Sith"]!, score: -1)
        ]),
        ScoreForName(userNameString: "renée", nameScoresForDestination: [
        ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 1),
        ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 1),
        ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 1),
        ScoreForDestination(destination: self.destinations["Slytherin"]!, score: -1),
        ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 1),
        ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 1),
        ScoreForDestination(destination: self.destinations["Death Eater"]!, score: -1),
        ScoreForDestination(destination: self.destinations["Muggle"]!, score: -1),
        ScoreForDestination(destination: self.destinations["Jedi"]!, score: 1),
        ScoreForDestination(destination: self.destinations["Sith"]!, score: -1)
        ]),
        ScoreForName(userNameString: "joe", nameScoresForDestination: [
        ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 1),
        ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 2),
        ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 1),
        ScoreForDestination(destination: self.destinations["Slytherin"]!, score: -1),
        ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 1),
        ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 1),
        ScoreForDestination(destination: self.destinations["Death Eater"]!, score: -1),
        ScoreForDestination(destination: self.destinations["Muggle"]!, score: -1),
        ScoreForDestination(destination: self.destinations["Jedi"]!, score: 1),
        ScoreForDestination(destination: self.destinations["Sith"]!, score: -1)
        ]),
        ScoreForName(userNameString: "joseph", nameScoresForDestination: [
        ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 1),
        ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 2),
        ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 1),
        ScoreForDestination(destination: self.destinations["Slytherin"]!, score: -1),
        ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 1),
        ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 1),
        ScoreForDestination(destination: self.destinations["Death Eater"]!, score: -1),
        ScoreForDestination(destination: self.destinations["Muggle"]!, score: -1),
        ScoreForDestination(destination: self.destinations["Jedi"]!, score: 1),
        ScoreForDestination(destination: self.destinations["Sith"]!, score: -1)
        ]),
        ScoreForName(userNameString: "julia", nameScoresForDestination: [
        ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 1),
        ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 1),
        ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: -1),
        ScoreForDestination(destination: self.destinations["Slytherin"]!, score: -1),
        ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 1),
        ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
        ScoreForDestination(destination: self.destinations["Death Eater"]!, score: -1),
        ScoreForDestination(destination: self.destinations["Muggle"]!, score: -1),
        ScoreForDestination(destination: self.destinations["Jedi"]!, score: 1),
        ScoreForDestination(destination: self.destinations["Sith"]!, score: -1)
        ]),
        ScoreForName(userNameString: "molly", nameScoresForDestination: [
        ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 1),
        ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 1),
        ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: -1),
        ScoreForDestination(destination: self.destinations["Slytherin"]!, score: -1),
        ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 1),
        ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
        ScoreForDestination(destination: self.destinations["Death Eater"]!, score: -1),
        ScoreForDestination(destination: self.destinations["Muggle"]!, score: -1),
        ScoreForDestination(destination: self.destinations["Jedi"]!, score: 1),
        ScoreForDestination(destination: self.destinations["Sith"]!, score: -1)
        ])
        ]
        print("Name Scores have been added to the Sorting Store")
        self.questions = [
            1: SortingQuestion(question: "Which of these have you thought the most since the Sorting began?", choices: [
                           SortingQuestion.SortingQuestionChoice(id: "not Slytherin", choiceText: "Not Slytherin, not Slytherin...", choiceScoresForDestinations: [
                               ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                               ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 0),
                               ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 0),
                               ScoreForDestination(destination: self.destinations["Slytherin"]!, score: -2),
                               ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 0),
                               ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                               ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                               ScoreForDestination(destination: self.destinations["Muggle"]!, score: 0),
                               ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                               ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                           ]),
                           SortingQuestion.SortingQuestionChoice(id: "Trump sucks", choiceText: "Donald Trump is a disastrous president.", choiceScoresForDestinations: [
                                   ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 1),
                                   ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 2),
                                   ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 1),
                                   ScoreForDestination(destination: self.destinations["Slytherin"]!, score: -1),
                                   ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 1),
                                   ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 1),
                                   ScoreForDestination(destination: self.destinations["Death Eater"]!, score: -1),
                                   ScoreForDestination(destination: self.destinations["Muggle"]!, score: -1),
                                   ScoreForDestination(destination: self.destinations["Jedi"]!, score: 1),
                                   ScoreForDestination(destination: self.destinations["Sith"]!, score: -1)
                               ]),
                           SortingQuestion.SortingQuestionChoice(id: "miss Obama", choiceText: "I miss Obama.", choiceScoresForDestinations: [
                                   ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 1),
                                   ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 1),
                                   ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 2),
                                   ScoreForDestination(destination: self.destinations["Slytherin"]!, score: -1),
                                   ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 2),
                                   ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 2),
                                   ScoreForDestination(destination: self.destinations["Death Eater"]!, score: -1),
                                   ScoreForDestination(destination: self.destinations["Muggle"]!, score: 0),
                                   ScoreForDestination(destination: self.destinations["Jedi"]!, score: 1),
                                   ScoreForDestination(destination: self.destinations["Sith"]!, score: -1)
                               ]),
                           SortingQuestion.SortingQuestionChoice(id: "kid's books", choiceText: "Harry Potter is for kids.", choiceScoresForDestinations: [
                                   ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: -1),
                                   ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: -1),
                                   ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: -1),
                                   ScoreForDestination(destination: self.destinations["Slytherin"]!, score: -1),
                                   ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: -1),
                                   ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: -1),
                                   ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                                   ScoreForDestination(destination: self.destinations["Muggle"]!, score: 2),
                                   ScoreForDestination(destination: self.destinations["Jedi"]!, score: 1),
                                   ScoreForDestination(destination: self.destinations["Sith"]!, score: 1)
                               ]),
                           SortingQuestion.SortingQuestionChoice(id: "hungry", choiceText: "I'm hungry.", choiceScoresForDestinations: [
                               ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                               ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 0),
                               ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 2),
                               ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 0),
                               ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 0),
                               ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                               ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                               ScoreForDestination(destination: self.destinations["Muggle"]!, score: 1),
                               ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                               ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                           ]),
                           SortingQuestion.SortingQuestionChoice(id: "maga", choiceText: "MAGA", choiceScoresForDestinations: [
                               ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: -2),
                               ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: -2),
                               ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: -2),
                               ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 2),
                               ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: -2),
                               ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: -2),
                               ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 2),
                               ScoreForDestination(destination: self.destinations["Muggle"]!, score: 1),
                               ScoreForDestination(destination: self.destinations["Jedi"]!, score: -2),
                               ScoreForDestination(destination: self.destinations["Sith"]!, score: 2)
                           ]),
                           SortingQuestion.SortingQuestionChoice(id: "star wars 9 sucked", choiceText: "I can't believe how badly J.J. Abrams screwed up the sequel trilogy.", choiceScoresForDestinations: [
                               ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: -1),
                               ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: -1),
                               ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: -1),
                               ScoreForDestination(destination: self.destinations["Slytherin"]!, score: -1),
                               ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: -1),
                               ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: -1),
                               ScoreForDestination(destination: self.destinations["Death Eater"]!, score: -1),
                               ScoreForDestination(destination: self.destinations["Muggle"]!, score: 1),
                               ScoreForDestination(destination: self.destinations["Jedi"]!, score: 2),
                               ScoreForDestination(destination: self.destinations["Sith"]!, score: 2)
                           ])
                           ]),
            2: SortingQuestion(question: "Who is your favorite Beatle?", choices: [
                SortingQuestion.SortingQuestionChoice(id: "john", choiceText: "John Lennon", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: -1),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "paul", choiceText: "Paul McCartney", choiceScoresForDestinations: [
                        ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 2),
                        ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 1),
                        ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Muggle"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                    ]),
                SortingQuestion.SortingQuestionChoice(id: "george", choiceText: "George Harrison", choiceScoresForDestinations: [
                        ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 1),
                        ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 1),
                        ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 1),
                        ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 1),
                        ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Muggle"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                    ]),
                SortingQuestion.SortingQuestionChoice(id: "ringo", choiceText: "Ringo Starr", choiceScoresForDestinations: [
                        ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: -1),
                        ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 2),
                        ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Muggle"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                    ])
                ]),
            3: SortingQuestion(question: "What would you prefer to do during a quidditch game?", choices: [
                SortingQuestion.SortingQuestionChoice(id: "seeker", choiceText: "Be the Seeker!", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: -1),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "chaser", choiceText: "Be a Chaser!", choiceScoresForDestinations: [
                        ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 1),
                        ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 1),
                        ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 1),
                        ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 1),
                        ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Muggle"]!, score: -1),
                        ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                    ]),
                SortingQuestion.SortingQuestionChoice(id: "beater", choiceText: "Be a Beater!", choiceScoresForDestinations: [
                        ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 1),
                        ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: -1),
                        ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 2),
                        ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Muggle"]!, score: -1),
                        ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                    ]),
                SortingQuestion.SortingQuestionChoice(id: "keeper", choiceText: "Be the Keeper!", choiceScoresForDestinations: [
                        ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 1),
                        ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 1),
                        ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 1),
                        ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 1),
                        ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Muggle"]!, score: -1),
                        ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                    ]),
                SortingQuestion.SortingQuestionChoice(id: "ref", choiceText: "Be the Referee!", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: -1),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "fan", choiceText: "Be a spectator in the stands!", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: -1),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: -1),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: -1),
                    ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: -1),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: -1),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "what", choiceText: "What's quidditch?", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: -1),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: -1),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: -1),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: -1),
                    ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 3),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                ])
                ]),
            4: SortingQuestion(question: "Which number is the most magical?", choices: [
                SortingQuestion.SortingQuestionChoice(id: "pi", choiceText: "3.14159", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "e", choiceText: "2.71828", choiceScoresForDestinations: [
                        ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 2),
                        ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 1),
                        ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Muggle"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                    ]),
                SortingQuestion.SortingQuestionChoice(id: "seven", choiceText: "7", choiceScoresForDestinations: [
                        ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 2),
                        ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 1),
                        ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 2),
                        ScoreForDestination(destination: self.destinations["Muggle"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                    ]),
                SortingQuestion.SortingQuestionChoice(id: "jenny", choiceText: "867-5309", choiceScoresForDestinations: [
                        ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: -1),
                        ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: -1),
                        ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: -1),
                        ScoreForDestination(destination: self.destinations["Slytherin"]!, score: -1),
                        ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: -2),
                        ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: -1),
                        ScoreForDestination(destination: self.destinations["Death Eater"]!, score: -1),
                        ScoreForDestination(destination: self.destinations["Muggle"]!, score: 3),
                        ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                    ]),
                    SortingQuestion.SortingQuestionChoice(id: "nine", choiceText: "IX", choiceScoresForDestinations: [
                            ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: -2),
                            ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: -2),
                            ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: -2),
                            ScoreForDestination(destination: self.destinations["Slytherin"]!, score: -2),
                            ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: -2),
                            ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: -2),
                            ScoreForDestination(destination: self.destinations["Death Eater"]!, score: -2),
                            ScoreForDestination(destination: self.destinations["Muggle"]!, score: 1),
                            ScoreForDestination(destination: self.destinations["Jedi"]!, score: 3),
                            ScoreForDestination(destination: self.destinations["Sith"]!, score: 3)
                        ])
                ]),
            5: SortingQuestion(question: "What is your favorite drink?", choices: [
                SortingQuestion.SortingQuestionChoice(id: "blue milk", choiceText: "Blue Milk", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 3),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 1)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "butter beer", choiceText: "Butter Beer", choiceScoresForDestinations: [
                        ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 1),
                        ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 1),
                        ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 3),
                        ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 1),
                        ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 2),
                        ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 2),
                        ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 1),
                        ScoreForDestination(destination: self.destinations["Muggle"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                    ]),
                    SortingQuestion.SortingQuestionChoice(id: "coffee", choiceText: "Coffee", choiceScoresForDestinations: [
                            ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                            ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 0),
                            ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 0),
                            ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 0),
                            ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 2),
                            ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                            ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                            ScoreForDestination(destination: self.destinations["Muggle"]!, score: 3),
                            ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                            ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                        ]),
                SortingQuestion.SortingQuestionChoice(id: "fire whiskey", choiceText: "Fire Whiskey", choiceScoresForDestinations: [
                        ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 1),
                        ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 1),
                        ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 1),
                        ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 1),
                        ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 2),
                        ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 2),
                        ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 2),
                        ScoreForDestination(destination: self.destinations["Muggle"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                    ]),
                SortingQuestion.SortingQuestionChoice(id: "enemy tears", choiceText: "The tears of my enemies", choiceScoresForDestinations: [
                        ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: -1),
                        ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: -1),
                        ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: -1),
                        ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 2),
                        ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: -2),
                        ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: -1),
                        ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 3),
                        ScoreForDestination(destination: self.destinations["Muggle"]!, score: 1),
                        ScoreForDestination(destination: self.destinations["Jedi"]!, score: -1),
                        ScoreForDestination(destination: self.destinations["Sith"]!, score: 3)
                    ]),
                    SortingQuestion.SortingQuestionChoice(id: "nagini milk", choiceText: "The milk of Nagini", choiceScoresForDestinations: [
                            ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: -2),
                            ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: -2),
                            ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: -2),
                            ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 1),
                            ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: -2),
                            ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: -2),
                            ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 3),
                            ScoreForDestination(destination: self.destinations["Muggle"]!, score: -1),
                            ScoreForDestination(destination: self.destinations["Jedi"]!, score: -1),
                            ScoreForDestination(destination: self.destinations["Sith"]!, score: 1)
                        ]),
                        SortingQuestion.SortingQuestionChoice(id: "apple juice", choiceText: "Apple juice", choiceScoresForDestinations: [
                                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 0),
                                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 1),
                                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 0),
                                ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 0),
                                ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                                ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                                ScoreForDestination(destination: self.destinations["Muggle"]!, score: 3),
                                ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                                ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                            ])
                ]),
            6: SortingQuestion(question: "What do you imagine your wand core would be?", choices: [
                SortingQuestion.SortingQuestionChoice(id: "phoenix feather", choiceText: "A phoenix feather", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: -1),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "unicorn hair", choiceText: "A unicorn hair", choiceScoresForDestinations: [
                        ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 1),
                        ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 1),
                        ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 1),
                        ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 1),
                        ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 1),
                        ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 1),
                        ScoreForDestination(destination: self.destinations["Muggle"]!, score: -1),
                        ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                    ]),
                SortingQuestion.SortingQuestionChoice(id: "malabrigo", choiceText: "Malabrigo wool", choiceScoresForDestinations: [
                        ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 1),
                        ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 2),
                        ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 2),
                        ScoreForDestination(destination: self.destinations["Slytherin"]!, score: -1),
                        ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 2),
                        ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 1),
                        ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Muggle"]!, score: -1),
                        ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                    ]),
                SortingQuestion.SortingQuestionChoice(id: "kyber crystal", choiceText: "A kyber crystal", choiceScoresForDestinations: [
                        ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: -1),
                        ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: -1),
                        ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: -1),
                        ScoreForDestination(destination: self.destinations["Slytherin"]!, score: -1),
                        ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: -1),
                        ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: -1),
                        ScoreForDestination(destination: self.destinations["Death Eater"]!, score: -1),
                        ScoreForDestination(destination: self.destinations["Muggle"]!, score: -1),
                        ScoreForDestination(destination: self.destinations["Jedi"]!, score: 3),
                        ScoreForDestination(destination: self.destinations["Sith"]!, score: 3)
                    ]),
                SortingQuestion.SortingQuestionChoice(id: "dragon heartstring", choiceText: "Dragon heartstring", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: -1),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "apple A14X", choiceText: "An A14X cpu", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: -2),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: -2),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: -2),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: -2),
                    ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: -2),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: -2),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: -2),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "plutonium", choiceText: "Plutonium", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: -1),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: -1),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: -1),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 2)
                ])
                ]),
            7: SortingQuestion(question: "How many spaces should be used after a period ending a sentence?", choices: [
            SortingQuestion.SortingQuestionChoice(id: "1", choiceText: "Just one. This is the 21st century.", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 1),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Muggle"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: 1)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "2", choiceText: "Two.  That's how I was raised.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                ]),
            SortingQuestion.SortingQuestionChoice(id: "anarchy", choiceText: "gRAmmaR-iS/faSCist*mAk3_Y0ur,0wN|rU1ez", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 2)
                ]),
            SortingQuestion.SortingQuestionChoice(id: "proust", choiceText: "Why would a sentence ever end when my thoughts meander like so much...", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                ]),
            SortingQuestion.SortingQuestionChoice(id: "whatever", choiceText: "Whatever Word tells me, I do.", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Muggle"]!, score: 1),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: 1),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
            ])
            ]),
            8: SortingQuestion(question: "Red pizza or white pizza?", choices: [
            SortingQuestion.SortingQuestionChoice(id: "red", choiceText: "Red. What are we even talking about?", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 1),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 1),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 1),
                ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 1),
                ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Muggle"]!, score: 1),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: 1)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "white", choiceText: "White. Don't you care about authenticity?", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                ]),
            SortingQuestion.SortingQuestionChoice(id: "more", choiceText: "Whatever, just bring more.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                ])
            ]),
            9: SortingQuestion(question: "What's your favorite screen?", choices: [
            SortingQuestion.SortingQuestionChoice(id: "phone", choiceText: "My phone. It's always with me.", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 1),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 1),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 1),
                ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 1),
                ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Muggle"]!, score: 1),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: 1)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "tablet", choiceText: "My tablet. It's perfect for downtime.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                ]),
            SortingQuestion.SortingQuestionChoice(id: "smoke", choiceText: "Smoke. Keep 'em guessing.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 2)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "silk", choiceText: "Silk. My t-shirts are 😎", choiceScoresForDestinations: [
                        ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 1),
                        ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 1),
                        ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                        ScoreForDestination(destination: self.destinations["Muggle"]!, score: 1),
                        ScoreForDestination(destination: self.destinations["Jedi"]!, score: 1),
                        ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                    ]),
                    SortingQuestion.SortingQuestionChoice(id: "desktop monitor", choiceText: "My work computer monitor. I'm kind of a big deal.", choiceScoresForDestinations: [
                            ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 1),
                            ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 1),
                            ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 1),
                            ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 1),
                            ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 1),
                            ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 1),
                            ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 1),
                            ScoreForDestination(destination: self.destinations["Muggle"]!, score: 1),
                            ScoreForDestination(destination: self.destinations["Jedi"]!, score: 1),
                            ScoreForDestination(destination: self.destinations["Sith"]!, score: 1)
                        ]),
                        SortingQuestion.SortingQuestionChoice(id: "tv", choiceText: "My television. And get off my lawn.", choiceScoresForDestinations: [
                                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 0),
                                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 0),
                                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 0),
                                ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 0),
                                ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                                ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                                ScoreForDestination(destination: self.destinations["Muggle"]!, score: 2),
                                ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                                ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                            ])
            ]),
            10: SortingQuestion(question: "What is your favorite season of The Wire?", choices: [
            SortingQuestion.SortingQuestionChoice(id: "1", choiceText: "First season. Where's Wallace?", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 1),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 1),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 1),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 1),
                ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Muggle"]!, score: 1),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: 1)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "2", choiceText: "Second season. The docks.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                ]),
            SortingQuestion.SortingQuestionChoice(id: "3", choiceText: "Third season. Hamsterdam.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 2)
                ]),
            SortingQuestion.SortingQuestionChoice(id: "4", choiceText: "Fourth season. Those kids.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                ]),
            SortingQuestion.SortingQuestionChoice(id: "5", choiceText: "Fifth season. Stop me, before I kill again.", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 1),
                ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 1),
                ScoreForDestination(destination: self.destinations["Muggle"]!, score: 2),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: 1)
            ])
            ]),
            11: SortingQuestion(question: "What kind of pie do you prefer?", choices: [
            SortingQuestion.SortingQuestionChoice(id: "apple", choiceText: "Apple.", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 1),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Muggle"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "pi", choiceText: "π", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 1)
                ]),
            SortingQuestion.SortingQuestionChoice(id: "rhubarb", choiceText: "Rhubarb", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                ]),
            SortingQuestion.SortingQuestionChoice(id: "strawberry rhubarb", choiceText: "Strawberry rhubarb", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 2)
                ]),
            SortingQuestion.SortingQuestionChoice(id: "sweetie", choiceText: "Sweetie.", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Muggle"]!, score: 1),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "cherry", choiceText: "Cherry", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Muggle"]!, score: 1),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "american", choiceText: "American (Bye Bye)", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Muggle"]!, score: 1),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
            ])
            ]),
            12: SortingQuestion(question: "Wand, stone, or cloak?", choices: [
            SortingQuestion.SortingQuestionChoice(id: "wand", choiceText: "Once won, the wand would serve me best.", choiceScoresForDestinations: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 1),
                ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 2),
                ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 1),
                ScoreForDestination(destination: self.destinations["Muggle"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: 1)
            ]),
            SortingQuestion.SortingQuestionChoice(id: "stone", choiceText: "With the stone, I could face even my greatest fears.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                ]),
            SortingQuestion.SortingQuestionChoice(id: "cloak", choiceText: "With the cloak, I can escape from danger.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "what", choiceText: "What are you talking about?", choiceScoresForDestinations: [
                        ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: -1),
                        ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: -1),
                        ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: -1),
                        ScoreForDestination(destination: self.destinations["Slytherin"]!, score: -1),
                        ScoreForDestination(destination: self.destinations["Hogwart's Headmaster"]!, score: -2),
                        ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: -1),
                        ScoreForDestination(destination: self.destinations["Death Eater"]!, score: -1),
                        ScoreForDestination(destination: self.destinations["Muggle"]!, score: 2),
                        ScoreForDestination(destination: self.destinations["Jedi"]!, score: 2),
                        ScoreForDestination(destination: self.destinations["Sith"]!, score: 2)
                    ])
            ])
        ]
        print("Questions have been loaded into the Sorting Store")
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
    
    deinit {
        print("The Sorting Store has been deinitialized.")
    }
}


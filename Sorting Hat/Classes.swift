//
//  Classes.swift
//  Sorting Hat
//
//  Created by Joshua Botts on 4/15/20.
//  Copyright © 2020 Joshua Botts. All rights reserved.
//

import Foundation

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
    }
    
    @Published var question: String
    @Published var choices: [SortingQuestionChoice]
    @Published var asked: Int
    
    init(question: String, choices: [SortingQuestionChoice]) {
        self.question = question
        self.choices = choices
        self.asked = 0
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
            "Hogwarts Headmaster": SortingDestination(name: "Hogwarts Headmaster", descriptionFull: "Every headmaster and headmistress of Hogwarts has brought something new to the weighty task of governing this historic school, and that is as it should be, for without progress there will be stagnation and decay."),
            "Dumbledore's Army": SortingDestination(name: "Dumbledore's Army", descriptionFull: "Every great wizard in history has started out as nothing more than what we are now: students. If they can do it, why not us?"),
            "Death Eater": SortingDestination(name: "Death Eater", descriptionFull: "They were a motley collection; a mixture of the weak seeking protection, the ambitious seeking some shared glory, and the thuggish gravitating toward a leader who could show them more refined forms of cruelty."),
            "Muggle": SortingDestination(name: "Muggle", descriptionFull: "Don’ listen properly, do they? Don’ look properly either. Never notice nuffink, they don’."),
            "Jedi": SortingDestination(name: "Jedi", descriptionFull: "There is no emotion, there is peace.\nThere is no ignorance, there is knowledge.\nThere is no passion, there is serenity.\nThere is no chaos, there is harmony.\nThere is no death, there is the Force."),
            "Sith": SortingDestination(name: "Sith", descriptionFull: "Peace is a lie. There is only passion.\nThrough passion I gain strength.\nThrough strength I gain power.\nThrough power I gain victory.\nThrough victory my chains are broken.\nThe Force shall free me.")
        ]
        print("Sorting Destinations have been loaded into the Sorting Store")
        self.nameScores = [
            ScoreForName(userNameString: "josh", nameScoresForDestination: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 1),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 1),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: -1),
                ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 1),
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
                ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 1),
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
                ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 1),
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
                ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 1),
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
                ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 2),
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
                ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 1),
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
                ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 1),
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
                ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 1),
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
                ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 1),
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
                ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 1),
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
                ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 1),
                ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Death Eater"]!, score: -1),
                ScoreForDestination(destination: self.destinations["Muggle"]!, score: -1),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: 1),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: -1)
            ]),
            ScoreForName(userNameString: "patti", nameScoresForDestination: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 1),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 1),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: -1),
                ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 1),
                ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 1),
                ScoreForDestination(destination: self.destinations["Death Eater"]!, score: -1),
                ScoreForDestination(destination: self.destinations["Muggle"]!, score: -1),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: 1),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: -1)
            ]),
            ScoreForName(userNameString: "mandy", nameScoresForDestination: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 1),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 1),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: -1),
                ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 1),
                ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 1),
                ScoreForDestination(destination: self.destinations["Death Eater"]!, score: -1),
                ScoreForDestination(destination: self.destinations["Muggle"]!, score: -1),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: 2),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
            ]),
            ScoreForName(userNameString: "eppy", nameScoresForDestination: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: -1),
                ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 1),
                ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 1),
                ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 1),
                ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 1),
                ScoreForDestination(destination: self.destinations["Muggle"]!, score: 2),
                ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                ScoreForDestination(destination: self.destinations["Sith"]!, score: 1)
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 0),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 1),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 2),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: -1),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 0),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: -2),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: -1),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 0),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 0),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 0),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 0),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 0),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 0),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 0),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 0),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 2),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: -1),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 3),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                ])
            ]),
            4: SortingQuestion(question: "Which of these numbers is the most magical?", choices: [
                SortingQuestion.SortingQuestionChoice(id: "pi", choiceText: "3.14159", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 0),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 1),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 1),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: -2),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: -2),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: -2),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: -2),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 3),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 3)
                ])
            ]),
            5: SortingQuestion(question: "Which of these drinks do you like best?", choices: [
                SortingQuestion.SortingQuestionChoice(id: "blue milk", choiceText: "Blue Milk", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 0),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 2),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 2),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 2),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: -2),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: -2),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: -2),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 3),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: -1),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: -1),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 1)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "apple juice", choiceText: "Apple Juice", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 3),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                ])
            ]),
            6: SortingQuestion(question: "Which of these would you prefer as your wand core?", choices: [
                SortingQuestion.SortingQuestionChoice(id: "phoenix feather", choiceText: "A phoenix feather", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 1),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 0),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 2),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: -1),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 1),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: -2),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 0),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 0),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 0),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 0),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 1),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 0),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 1),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 0),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                ])
            ]),
            9: SortingQuestion(question: "Which of these is your favorite screen?", choices: [
                SortingQuestion.SortingQuestionChoice(id: "phone", choiceText: "My phone. It's always with me.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 1),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 0),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 1),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 1),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 1),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 0),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 0),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 0),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 1),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 2),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 1)
                ])
            ]),
            11: SortingQuestion(question: "Which of these pies do you prefer?", choices: [
                SortingQuestion.SortingQuestionChoice(id: "apple", choiceText: "Apple.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 0),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 0),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 2),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 0),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 0),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 0),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 0),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 2),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 0),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 0),
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
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: -2),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: -1),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: -1),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 2)
                ])
            ]),
            13: SortingQuestion(question: "You stand alone against the forces of evil. What spell do you cast?", choices: [
                SortingQuestion.SortingQuestionChoice(id: "imperio", choiceText: "Imperio!", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 3),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 2)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "expelliarmus", choiceText: "Expelliarmus!", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "patronus", choiceText: "Expecto patronum!", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: -1),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "protego", choiceText: "Protego!", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: -1),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: -2),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: -1)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "apparate", choiceText: "Sorry. Gotta apparate out of here.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: -2),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: -2),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: -2),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 1)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "morsmordre", choiceText: "Morsmordre!", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: -2),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: -2),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: -2),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: -2),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: -2),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 3),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: -1),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 2)
                ])
            ]),
            14: SortingQuestion(question: "Which of these vacations would you prefer?", choices: [
                SortingQuestion.SortingQuestionChoice(id: "beach", choiceText: "Take me to the beach!", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 1)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "hike", choiceText: "Let's go on spectacular hike!", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "staycation", choiceText: "I'm going to stay home with a pile of books!", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "tatooine", choiceText: "I don't care as long as we stop on Tatooine to pick up some power converters.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 2)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "disney", choiceText: "I'm going to Disney World!", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "travel", choiceText: "I don't care as long as we go somewhere I've never been before.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: -1),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 1)
                ])
            ]),
            15: SortingQuestion(question: "Which class do you prefer?", choices: [
                SortingQuestion.SortingQuestionChoice(id: "history", choiceText: "History", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 1)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "math", choiceText: "Math", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 1)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "Science", choiceText: "Science", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 2)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "yoga", choiceText: "Yoga", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 1)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "music", choiceText: "Music", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "english", choiceText: "English", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "foreign language", choiceText: "Foreign Language", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: -1),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: -1),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "art", choiceText: "Art", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: -1),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: -1),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "gym", choiceText: "Gym", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: -1),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: -1),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 1)
                ])
            ]),
            16: SortingQuestion(question: "Who is your favorite Weasley?", choices: [
                SortingQuestion.SortingQuestionChoice(id: "molly", choiceText: "Molly.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: -1),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: -1),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "arthur", choiceText: "Arthur.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: -1),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "bill", choiceText: "Bill.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "charlie", choiceText: "Charlie.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "percy", choiceText: "Percy.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 1)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "george", choiceText: "George.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "fred", choiceText: "Fred.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "ron", choiceText: "Ron.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: -1),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "ginny", choiceText: "Ginny.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: -1),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: -1),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                ])
            ]),
            17: SortingQuestion(question: "What would you be most likely to see in the Mirror of Erised?", choices: [
                SortingQuestion.SortingQuestionChoice(id: "socks", choiceText: "Thick, wool socks.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 3),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "balance", choiceText: "A balance, and some faded texts from a galaxy far, far away.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 3),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "hp8", choiceText: "An eighth Harry Potter book. And not that Cursed Child nonsense.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "family", choiceText: "Myself and my family, a little older, a little happier, and surrounded by all of our friends.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "kushner", choiceText: "Jared Kushner, giving me a high five.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: -1),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: -1),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: -1),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: -1),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: -1),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: -1),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: -1),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 2)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "myself", choiceText: "Myself, just as I am.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "rhubarb", choiceText: "Piles and piles of rhubarb.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: -1),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: -1),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: -1),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: -1),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: -1)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "money", choiceText: "A vault chock full of money, ready for me to dive in like Scrooge McDuck.", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: 2),
                    ScoreForDestination(destination: self.destinations["Hogwarts Headmaster"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Dumbledore's Army"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Death Eater"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Muggle"]!, score: 1),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: 0),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: 0)
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



//
//  KidModeStore.swift
//  Sorting Hat
//
//  Created by Joshua Botts on 5/29/20.
//  Copyright © 2020 Joshua Botts. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

extension SortingStore {
    func setKidStore(user: String) {
        let destiny: Int = 500
        let highest: Int = Int.random(in: 5...7)
        let higher: Int = Int.random(in: 3...5)
        let high: Int = Int.random(in: 1...3)
        let neutral: Int = Int.random(in: -1...1)
        let low: Int = Int.random(in: -3 ... -1)
        let lower: Int = Int.random(in: -5 ... -3)
        let lowest: Int = Int.random(in: -7 ... -5)
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
                ScoreForDestination(destination: self.destinations["Ravenclaw Prefect"]!, score: destiny)
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
                ScoreForDestination(destination: self.destinations["Dark Lord"]!, score: destiny)
            ]),
            ScoreForName(userNameString: "potter", nameScoresForDestination: [
                ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: highest)
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
                SortingQuestion.SortingQuestionChoice(id: "mace", choiceText: "mace", choiceImage: "mace", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: lower)
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
                SortingQuestion.SortingQuestionChoice(id: "ahsoka", choiceText: "ahsoka", choiceImage: "ahsoka", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: highest),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: lowest)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "grievous", choiceText: "grievous", choiceImage: "grievous", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: lower),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: higher)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "obiwan", choiceText: "obiwan", choiceImage: "obiwan", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: lower)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "dooku", choiceText: "dooku", choiceImage: "dooku", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: lower),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: higher)
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
            15: SortingQuestion(kidMode: true, question: "Which of these PBS Kids shows do you like best?", choices: [
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
            ]),
            17: SortingQuestion(kidMode: true, question: "Which of these magical creatures do you like best?", choices: [
                SortingQuestion.SortingQuestionChoice(id: "dragon", choiceText: "dragon", choiceImage: "dragon", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: low)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "bowtruckle", choiceText: "bowtruckle", choiceImage: "bowtruckle", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: low)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "unicorn", choiceText: "unicorn", choiceImage: "unicorn", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: low)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "niffler", choiceText: "niffler", choiceImage: "niffler", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: low)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "pixie", choiceText: "pixie", choiceImage: "pixie", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: low)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "hippogriff", choiceText: "hippogriff", choiceImage: "hippogriff", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: low)
                ])
            ]),
            18: SortingQuestion(kidMode: true, question: "Who is your favorite Weasley?", choices: [
                SortingQuestion.SortingQuestionChoice(id: "molly", choiceText: "molly", choiceImage: "molly", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "arthur", choiceText: "arthur", choiceImage: "arthur", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "bill", choiceText: "bill", choiceImage: "bill", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "percy", choiceText: "percy", choiceImage: "percy", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: high)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "george", choiceText: "george", choiceImage: "george", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "fred", choiceText: "fred", choiceImage: "fred", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "ron", choiceText: "ron", choiceImage: "ron", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "ginny", choiceText: "ginny", choiceImage: "ginny", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: higher),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: low),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: high),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ])
            ]),
            19: SortingQuestion(kidMode: true, question: "Which of these ponies do you like best?", choices: [
                SortingQuestion.SortingQuestionChoice(id: "applejack", choiceText: "applejack", choiceImage: "applejack", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "fluttershy", choiceText: "fluttershy", choiceImage: "fluttershy", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "pinkie pie", choiceText: "pinkie pie", choiceImage: "pinkie pie", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "rainbow dash", choiceText: "rainbow dash", choiceImage: "rainbow dash", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "rarity", choiceText: "rarity", choiceImage: "rarity", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "twilight sparkle", choiceText: "twilight sparkle", choiceImage: "twilight sparkle", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ])
            ]),
            20: SortingQuestion(kidMode: true, question: "Which of these Peppa Pig characters do you like best?", choices: [
                SortingQuestion.SortingQuestionChoice(id: "candy cat", choiceText: "candy cat", choiceImage: "candy cat", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "daddy pig", choiceText: "daddy pig", choiceImage: "daddy pig", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "danny dog", choiceText: "danny dog", choiceImage: "danny dog", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "emily elephant", choiceText: "emily elephant", choiceImage: "emily elephant", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "freddie fox", choiceText: "freddie fox", choiceImage: "freddie fox", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "george pig", choiceText: "george pig", choiceImage: "george pig", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "gerald giraffe", choiceText: "gerald giraffe", choiceImage: "gerald giraffe", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "grandpa pig", choiceText: "grandpa pig", choiceImage: "grandpa pig", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "granny pig", choiceText: "granny pig", choiceImage: "granny pig", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "mandy mouse", choiceText: "mandy mouse", choiceImage: "mandy mouse", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "molly mole", choiceText: "molly mole", choiceImage: "molly mole", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "mummy pig", choiceText: "mummy pig", choiceImage: "mummy pig", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "pedro pony", choiceText: "pedro pony", choiceImage: "pedro pony", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "peppa pig", choiceText: "peppa pig", choiceImage: "peppa pig", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "rebecca rabbit", choiceText: "rebecca rabbit", choiceImage: "rebecca rabbit", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "suzy sheep", choiceText: "suzy sheep", choiceImage: "suzy sheep", choiceScoresForDestinations: [
                    ScoreForDestination(destination: self.destinations["Gryffindor"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Ravenclaw"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Hufflepuff"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Slytherin"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Jedi"]!, score: neutral),
                    ScoreForDestination(destination: self.destinations["Sith"]!, score: neutral)
                ]),
                SortingQuestion.SortingQuestionChoice(id: "zoe zebra", choiceText: "zoe zebra", choiceImage: "zoe zebra", choiceScoresForDestinations: [
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
}

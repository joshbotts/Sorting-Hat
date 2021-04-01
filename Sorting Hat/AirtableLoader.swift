//
//  AirtableLoader.swift
//  Sorting Hat
//
//  Created by Joshua Botts on 3/30/21.
//  Copyright © 2021 Joshua Botts. All rights reserved.
//

import Foundation

class AirtableLoader: ObservableObject {
    let controller = AirtableController()
    var destinations = [String: AirtableDestination]()
    var questions = [String: AirtableQuestion]()
    var choices = [String: AirtableChoice]()
    var scores = [String: AirtableScore]()
    var names = [String: AirtableName]()
    @Published var state: AirtableState = .incomplete
    var tempDestinations = [AirtableDestinationRecords]()
    var tempScores = [AirtableScoreRecords]()
    var tempNames = [AirtableNameRecords]()
    var tempChoices = [AirtableChoiceRecords]()
    var tempQuestions = [AirtableQuestionRecords]()
    
    enum AirtableState: String {
        case incomplete = "Loading."
        case destinationsLoaded = "Loading.."
        case scoresLoaded = "Loading..."
        case choicesLoaded = "Loading...."
        case questionsLoaded = "Loading....."
        case baseLoaded = "Loading......"
        case complete = "Loaded"
    }
    
    func loadBase() {
        self.controller.getDestinations(handleResponse: loadDestinations)
        self.controller.getScores(handleResponse: loadScores)
        self.controller.getNames(handleResponse: loadNames)
        self.controller.getChoices(handleResponse: loadChoices)
        self.controller.getQuestions(handleResponse: loadQuestions)
        DispatchQueue.main.async {
            self.state = .baseLoaded
        }
    }
    
    func loadDestinations(offset: String?, response: AirtableDestinationRecords) {
    self.tempDestinations.append(response)
        if let offset = offset {
            controller.getMoreDestinations(offset: offset, handleResponse: self.loadDestinations)
        } else {
            let flattenedResponses = self.tempDestinations.flatMap { $0.records }
            for destination in flattenedResponses {
                let destinationID = destination.id
                self.destinations[destinationID] = destination
                print("Added destination ID: \(destinationID) (\(destination.fields.name)) to AirtableStore")
                self.downloadMovie(destinationName: destination.fields.name, destinationURL: destination.fields.movie[0].url, completion: saveMovie)
            }
            print("Destinations downloaded")
            DispatchQueue.main.async {
                self.state = .destinationsLoaded
            }
        }
    }
    
    func loadScores(offset: String?, response: AirtableScoreRecords) {
        self.tempScores.append(response)
        if let offset = offset {
            controller.getMoreScores(offset: offset, handleResponse: self.loadScores)
        } else {
            let flattenedResponses = self.tempScores.flatMap { $0.records }
            for score in flattenedResponses {
                let scoreID = score.id
                self.scores[scoreID] = score
                print("Added score ID: \(scoreID) (\(score.fields.destinationScore)) to AirtableStore")
            }
            print("Scores downloaded")
            DispatchQueue.main.async {
                self.state = .scoresLoaded
            }
        }
    }
    
    
    func loadNames(offset: String?, response: AirtableNameRecords) {
        self.tempNames.append(response)
        if let offset = offset {
            controller.getMoreNames(offset: offset, handleResponse: self.loadNames)
        } else {
            let flattenedResponses = self.tempNames.flatMap { $0.records }
            for name in flattenedResponses {
                let nameID = name.id
                self.names[nameID] = name
                print("Added name ID: \(nameID) (\(name.fields.name)) to AirtableStore")
            }
            print("Names downloaded")
            DispatchQueue.main.async {
                self.state = .scoresLoaded
            }
        }
    }
    
    func loadChoices(offset: String?, response: AirtableChoiceRecords) {
        self.tempChoices.append(response)
        if let offset = offset {
            controller.getMoreChoices(offset: offset, handleResponse: self.loadChoices)
        } else {
            let flattenedResponses = self.tempChoices.flatMap { $0.records }
            for choice in flattenedResponses {
                let choiceID = choice.id
                self.choices[choiceID] = choice
                print("Added choice ID: \(choiceID) for question ID: \(choice.fields.question) (\(choice.fields.choice)) to AirtableStore")
                if choice.fields.image != nil {
                    self.downloadChoiceImage(choiceID: choice.id, choiceURL: choice.fields.image![0].url, ext: String(choice.fields.image![0].filename.suffix(4)), completion: saveChoiceImage)
                }
            }
            print("Choices downloaded")
            DispatchQueue.main.async {
                self.state = .choicesLoaded
            }
        }
    }
    
    func loadQuestions(offset: String?, response: AirtableQuestionRecords) {
        self.tempQuestions.append(response)
        if let offset = offset {
            controller.getMoreQuestions(offset: offset, handleResponse: self.loadQuestions)
        } else {
            let flattenedResponses = self.tempQuestions.flatMap { $0.records }
            for question in flattenedResponses {
                let questionID = question.id
                self.questions[questionID] = question
                print("Added question ID: \(questionID) (\(question.fields.question)) to AirtableStore")
            }
            print("Questions downloaded")
            DispatchQueue.main.async {
                self.state = .questionsLoaded
            }
        }
    }
    
    func downloadMovie(destinationName: String, destinationURL: URL, completion: @escaping (String, Data) -> Void) {
        let request = URLRequest(url: destinationURL)
        let task = controller.session.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                print(response as Any)
                return
            }
            if let data = data
            {
                completion(destinationName, data)
            }
            else {
                print(response)
            }
        }
        task.resume()
    }
    
    func saveMovie(destination: String, data: Data) {
        try! data.write(to: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(destination).appendingPathExtension(".mov"))
        print("Movie for \(destination) saved")
    }
    
    func downloadChoiceImage(choiceID: String, choiceURL: URL, ext: String, completion: @escaping (String, Data, String) -> Void) {
        let request = URLRequest(url: choiceURL)
        let task = controller.session.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                print(response as Any)
                return
            }
            if let data = data
            {
                completion(choiceID, data, ext)
            }
            else {
                print(response)
            }
        }
        task.resume()
    }
    
    func saveChoiceImage(choice: String, data: Data, ext: String) {
        try! data.write(to: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(choice).appendingPathExtension(ext))
        print("Image for \(choice) saved")
    }
    
    func transcodeBase(store: SortingStore) {
        for destination in self.destinations.values {
            let transcoded = SortingDestination(id: destination.id, name: destination.fields.name, descriptionFull: destination.fields.description)
            store.destinations[transcoded.name] = transcoded
            print("Added destination \(transcoded.name)")
        }
        var scores = [String: ScoreForDestination]()
        for score in self.scores.values {
            let transcoded = ScoreForDestination(id: score.id, destination: store.destinations[self.destinations[score.fields.destination[0]]!.fields.name]!, score: score.fields.points)
            scores[score.id] = transcoded
            print("Added score \(transcoded.score) for \(transcoded.destination)")
        }
        var airtableChoices = [String: SortingQuestion.SortingQuestionChoice]()
        for choice in self.choices.values {
            var choiceScores = [ScoreForDestination]()
            for score in choice.fields.scores {
                choiceScores.append(scores[score]!)
            }
            let transcoded = SortingQuestion.SortingQuestionChoice(id: choice.id, choiceText: choice.fields.choice, choiceImage: choice.id, choiceScoresForDestinations: choiceScores)
            airtableChoices[choice.id] = transcoded
            print("Added choice \(transcoded.choiceText)")
        }
        for question in self.questions.values {
            var choices = [SortingQuestion.SortingQuestionChoice]()
            for choice in question.fields.choices {
                choices.append(airtableChoices[choice]!)
            }
            let transcoded = SortingQuestion(id: question.id, kidMode: question.fields.kidsMode ?? false, question: question.fields.question, choices:
                                                choices)
            store.questions[question.fields.number] = transcoded
            print("Added question \(transcoded.question)")
        }
        for name in self.names.values {
            var nameScores = [ScoreForDestination]()
            for score in name.fields.scores {
                nameScores.append(scores[score]!)
            }
            let transcoded = ScoreForName(id: name.id, userNameString: name.fields.name, nameScoresForDestination: nameScores)
            store.nameScores.append(transcoded)
            print("Added name scores for \(transcoded.userNameString)")
        }
        DispatchQueue.main.async {
            store.mode = .start
            self.state = .complete
        }
    }
    
    func baseToStore(store: SortingStore) {
        self.transcodeBase(store: store)
    }
}

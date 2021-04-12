//
//  AirtableLoader.swift
//  Sorting Hat
//
//  Created by Joshua Botts on 3/30/21.
//  Copyright © 2021 Joshua Botts. All rights reserved.
//

import Foundation

class AirtableLoader: ObservableObject {
    var destinations = [String: AirtableDestination]()
    var questions = [String: AirtableQuestion]()
    var choices = [String: AirtableChoice]()
    var scores = [String: AirtableScore]()
    var names = [String: AirtableName]()
    @Published var state: AirtableState = .incomplete {
        didSet {
            completeSetup()
        }
    }
    var tempDestinations = [AirtableDestinationRecords]()
    var tempScores = [AirtableScoreRecords]()
    var tempNames = [AirtableNameRecords]()
    var tempChoices = [AirtableChoiceRecords]()
    var tempQuestions = [AirtableQuestionRecords]()
    var destinationsLoaded: Bool = false
    var choicesLoaded: Bool = false
    var scoresLoaded: Bool = false
    var questionsLoaded: Bool = false
    var namesLoaded: Bool = false
    
    
    enum AirtableState: String {
        case incomplete = "Loading."
        case destinationsLoaded = "Loading.."
        case scoresLoaded = "Loading..."
        case choicesLoaded = "Loading...."
        case questionsLoaded = "Loading....."
        case baseLoaded = "Loading......"
        case complete = "Loaded"
    }
    
    // AirtableConfig is a struct with two constant properties: my Airtable base URL and my API key
    // read-only link to Airtable data source: https://airtable.com/invite/l?inviteId=invKAaewa7LbKW80n&inviteToken=a6360616462a543566787cc2123c158c160b1a6506dbbb1c36afa66b0674a3fe
    let config = AirtableConfig()
    let session = URLSession.shared
    
    func getDestinations(handleResponse: @escaping (String?, AirtableDestinationRecords) -> Void) {
        var request = URLRequest(url: config.baseURL.appendingPathComponent(AirtableTables.destinations.rawValue))
        request.addValue("Bearer \(config.apiKey)", forHTTPHeaderField: "Authorization")
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let jsonData = data else {
                        print("Server response is \(String(describing: response)). Data could not be decoded.")
                        return
                    }
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(AirtableDestinationRecords.self, from: jsonData)
                        for record in result.records {
                            print("Destination record \(record.id): \(record.fields.name) decoded")
                        }
                        handleResponse(result.offset ?? nil, result)
                    } catch {
                        print(error)
                    }
                }
                dataTask.resume()
    }
    
    func getMoreDestinations(offset: String, handleResponse: @escaping (String?, AirtableDestinationRecords) -> Void) {
        var url: URL = config.baseURL.appendingPathComponent(AirtableTables.destinations.rawValue)
        let queryItem = URLQueryItem(name: "offset", value: offset)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = [queryItem]
        url = (components?.url)!
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(config.apiKey)", forHTTPHeaderField: "Authorization")
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let jsonData = data else {
                        print("Server response is \(String(describing: response)). Data could not be decoded.")
                        return
                    }
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(AirtableDestinationRecords.self, from: jsonData)
                        for record in result.records {
                            print("Destination record \(record.id): \(record.fields.name) decoded")
                        }
                        handleResponse(result.offset ?? nil, result)
                    } catch {
                        print(error)
                    }
                }
                dataTask.resume()
    }
    
    func getScores(handleResponse: @escaping (String?, AirtableScoreRecords) -> Void) {
        var request = URLRequest(url: config.baseURL.appendingPathComponent(AirtableTables.scores.rawValue))
        request.addValue("Bearer \(config.apiKey)", forHTTPHeaderField: "Authorization")
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let jsonData = data else {
                        print("Server response is \(String(describing: response)). Data could not be decoded.")
                        return
                    }
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(AirtableScoreRecords.self, from: jsonData)
                        for record in result.records {
                            print("Score record \(record.id): \(record.fields.destinationScore) decoded")
                        }
                        handleResponse(result.offset ?? nil, result)
                    } catch {
                        print(error)
                    }
                }
                dataTask.resume()
    }
    
    func getMoreScores(offset: String, handleResponse: @escaping (String?, AirtableScoreRecords) -> Void) {
        var url: URL = config.baseURL.appendingPathComponent(AirtableTables.scores.rawValue)
        let queryItem = URLQueryItem(name: "offset", value: offset)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = [queryItem]
        url = (components?.url)!
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(config.apiKey)", forHTTPHeaderField: "Authorization")
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let jsonData = data else {
                        print("Server response is \(String(describing: response)). Data could not be decoded.")
                        return
                    }
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(AirtableScoreRecords.self, from: jsonData)
                        for record in result.records {
                            print("Score record \(record.id): \(record.fields.destinationScore) decoded")
                        }
                        handleResponse(result.offset ?? nil, result)
                    } catch {
                        print(error)
                    }
                }
                dataTask.resume()
    }
    
    func getChoices(handleResponse: @escaping (String?, AirtableChoiceRecords) -> Void) {
        var request = URLRequest(url: config.baseURL.appendingPathComponent(AirtableTables.choices.rawValue))
        request.addValue("Bearer \(config.apiKey)", forHTTPHeaderField: "Authorization")
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let jsonData = data else {
                        print("Server response is \(String(describing: response)). Data could not be decoded.")
                        return
                    }
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(AirtableChoiceRecords.self, from: jsonData)
                        for record in result.records {
                            print("Choice record \(record.id): \(record.fields.choice) for question id \(record.fields.question) decoded")
                        }
                        handleResponse(result.offset ?? nil, result)
                    } catch {
                        print(error)
                    }
                }
                dataTask.resume()
    }
    
    func getMoreChoices(offset: String, handleResponse: @escaping (String?, AirtableChoiceRecords) -> Void) {
        var url: URL = config.baseURL.appendingPathComponent(AirtableTables.choices.rawValue)
        let queryItem = URLQueryItem(name: "offset", value: offset)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = [queryItem]
        url = (components?.url)!
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(config.apiKey)", forHTTPHeaderField: "Authorization")
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let jsonData = data else {
                        print("Server response is \(String(describing: response)). Data could not be decoded.")
                        return
                    }
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(AirtableChoiceRecords.self, from: jsonData)
                        for record in result.records {
                            print("Choice record \(record.id): \(record.fields.choice) for question id \(record.fields.question) decoded")
                        }
                        handleResponse(result.offset ?? nil, result)
                    } catch {
                        print(error)
                    }
                }
                dataTask.resume()
    }
    
    func getNames(handleResponse: @escaping (String?, AirtableNameRecords) -> Void) {
        var request = URLRequest(url: config.baseURL.appendingPathComponent(AirtableTables.names.rawValue))
        request.addValue("Bearer \(config.apiKey)", forHTTPHeaderField: "Authorization")
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let jsonData = data else {
                        print("Server response is \(String(describing: response)). Data could not be decoded.")
                        return
                    }
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(AirtableNameRecords.self, from: jsonData)
                        for record in result.records {
                            print("Name record \(record.id): \(record.fields.name) decoded")
                        }
                        handleResponse(result.offset ?? nil, result)
                    } catch {
                        print(error)
                    }
                }
                dataTask.resume()
    }
    
    func getMoreNames(offset: String, handleResponse: @escaping (String?, AirtableNameRecords) -> Void) {
        var url: URL = config.baseURL.appendingPathComponent(AirtableTables.names.rawValue)
        let queryItem = URLQueryItem(name: "offset", value: offset)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = [queryItem]
        url = (components?.url)!
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(config.apiKey)", forHTTPHeaderField: "Authorization")
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let jsonData = data else {
                        print("Server response is \(String(describing: response)). Data could not be decoded.")
                        return
                    }
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(AirtableNameRecords.self, from: jsonData)
                        for record in result.records {
                            print("Score record \(record.id): \(record.fields.name) decoded")
                        }
                        handleResponse(result.offset ?? nil, result)
                    } catch {
                        print(error)
                    }
                }
                dataTask.resume()
    }
    
    func getQuestions(handleResponse: @escaping (String?, AirtableQuestionRecords) -> Void) {
        
        var request = URLRequest(url: config.baseURL.appendingPathComponent(AirtableTables.questions.rawValue))
        request.addValue("Bearer \(config.apiKey)", forHTTPHeaderField: "Authorization")
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let jsonData = data else {
                        print("Server response is \(String(describing: response)). Data could not be decoded.")
                        return
                    }
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(AirtableQuestionRecords.self, from: jsonData)
                        for record in result.records {
                            print("Score record \(record.id): \(record.fields.question) decoded")
                        }
                        handleResponse(result.offset ?? nil, result)
                    } catch {
                        print(error)
                    }
                }
                dataTask.resume()
    }
    
    func getMoreQuestions(offset: String, handleResponse: @escaping (String?, AirtableQuestionRecords) -> Void) {
        var url: URL = config.baseURL.appendingPathComponent(AirtableTables.questions.rawValue)
        let queryItem = URLQueryItem(name: "offset", value: offset)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = [queryItem]
        url = (components?.url)!
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(config.apiKey)", forHTTPHeaderField: "Authorization")
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let jsonData = data else {
                        print("Server response is \(String(describing: response)). Data could not be decoded.")
                        return
                    }
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(AirtableQuestionRecords.self, from: jsonData)
                        for record in result.records {
                            print("Score record \(record.id): \(record.fields.question) decoded")
                        }
                        handleResponse(result.offset ?? nil, result)
                    } catch {
                        print(error)
                    }
                }
                dataTask.resume()
    }
    
    func loadBase() {
        self.getDestinations(handleResponse: loadDestinations)
        self.getScores(handleResponse: loadScores)
        self.getNames(handleResponse: loadNames)
        self.getChoices(handleResponse: loadChoices)
        self.getQuestions(handleResponse: loadQuestions)
    }
    
    func completeSetup() {
        DispatchQueue.main.async {
            if self.destinationsLoaded && self.questionsLoaded && self.choicesLoaded && self.namesLoaded && self.scoresLoaded {
                self.state = .baseLoaded
            }
        }
    }
    
    func loadDestinations(offset: String?, response: AirtableDestinationRecords) {
    self.tempDestinations.append(response)
        if let offset = offset {
            getMoreDestinations(offset: offset, handleResponse: self.loadDestinations)
        } else {
            let flattenedResponses = self.tempDestinations.flatMap { $0.records }
            for destination in flattenedResponses {
                let destinationID = destination.id
                self.destinations[destinationID] = destination
                print("Added destination ID: \(destinationID) (\(destination.fields.name)) to AirtableStore")
                self.downloadMovie(destinationName: destination.fields.name, destinationURL: destination.fields.movie[0].url, completion: saveMovie)
            }
            print("Destinations downloaded")
            self.destinationsLoaded = true
            DispatchQueue.main.async {
                self.state = .destinationsLoaded
            }
        }
    }
    
    func loadScores(offset: String?, response: AirtableScoreRecords) {
        self.tempScores.append(response)
        if let offset = offset {
            getMoreScores(offset: offset, handleResponse: self.loadScores)
        } else {
            let flattenedResponses = self.tempScores.flatMap { $0.records }
            for score in flattenedResponses {
                let scoreID = score.id
                self.scores[scoreID] = score
                print("Added score ID: \(scoreID) (\(score.fields.destinationScore)) to AirtableStore")
            }
            print("Scores downloaded")
            self.scoresLoaded = true
            DispatchQueue.main.async {
                self.state = .scoresLoaded
            }
        }
    }
    
    
    func loadNames(offset: String?, response: AirtableNameRecords) {
        self.tempNames.append(response)
        if let offset = offset {
            getMoreNames(offset: offset, handleResponse: self.loadNames)
        } else {
            let flattenedResponses = self.tempNames.flatMap { $0.records }
            for name in flattenedResponses {
                let nameID = name.id
                self.names[nameID] = name
                print("Added name ID: \(nameID) (\(name.fields.name)) to AirtableStore")
            }
            print("Names downloaded")
            self.namesLoaded = true
            DispatchQueue.main.async {
                self.state = .scoresLoaded
            }
        }
    }
    
    // , ext: String(choice.fields.image![0].filename.suffix(4))
    
    func loadChoices(offset: String?, response: AirtableChoiceRecords) {
        self.tempChoices.append(response)
        if let offset = offset {
            getMoreChoices(offset: offset, handleResponse: self.loadChoices)
        } else {
            let flattenedResponses = self.tempChoices.flatMap { $0.records }
            for choice in flattenedResponses {
                let choiceID = choice.id
                self.choices[choiceID] = choice
                print("Added choice ID: \(choiceID) for question ID: \(choice.fields.question) (\(choice.fields.choice)) to AirtableStore")
                if choice.fields.image != nil {
                    self.downloadChoiceImage(choiceID: choice.id, choiceURL: choice.fields.image![0].url, completion: saveChoiceImage)
                }
            }
            print("Choices downloaded")
            self.choicesLoaded = true
            DispatchQueue.main.async {
                self.state = .choicesLoaded
            }
        }
    }
    
    func loadQuestions(offset: String?, response: AirtableQuestionRecords) {
        self.tempQuestions.append(response)
        if let offset = offset {
            getMoreQuestions(offset: offset, handleResponse: self.loadQuestions)
        } else {
            let flattenedResponses = self.tempQuestions.flatMap { $0.records }
            for question in flattenedResponses {
                let questionID = question.id
                self.questions[questionID] = question
                print("Added question ID: \(questionID) (\(question.fields.question)) to AirtableStore")
            }
            print("Questions downloaded")
            self.questionsLoaded = true
            DispatchQueue.main.async {
                self.state = .questionsLoaded
            }
        }
    }
    
    func downloadMovie(destinationName: String, destinationURL: URL, completion: @escaping (String, Data) -> Void) {
        let request = URLRequest(url: destinationURL)
        let task = session.dataTask(with: request) { data, response, error in
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
    
    // ext: String,
    //, ext
    // , String
    
    
    func downloadChoiceImage(choiceID: String, choiceURL: URL, completion: @escaping (String, Data) -> Void) {
        let request = URLRequest(url: choiceURL)
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                print(response as Any)
                return
            }
            if let data = data
            {
                completion(choiceID, data)
            }
            else {
                print(response)
            }
        }
        task.resume()
    }
    
    // , ext: String
    // .appendingPathExtension(ext)
    
    func saveChoiceImage(choice: String, data: Data) {
        try! data.write(to: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(choice))
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
            print("Initialized score \(transcoded.score) for \(transcoded.destination)")
        }
        var airtableChoices = [String: SortingQuestion.SortingQuestionChoice]()
        for choice in self.choices.values {
            var choiceScores = [ScoreForDestination]()
            for score in choice.fields.scores {
                choiceScores.append(scores[score]!)
            }
            let transcoded = SortingQuestion.SortingQuestionChoice(id: choice.id, choiceText: choice.fields.choice, choiceImage: choice.id, choiceScoresForDestinations: choiceScores)
            airtableChoices[choice.id] = transcoded
            print("Initialized choice \(transcoded.choiceText)")
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
            let transcoded = ScoreForName(id: name.id, userNameString: name.fields.name.lowercased(), nameScoresForDestination: nameScores)
            store.nameScores.append(transcoded)
            print("Added name scores for \(transcoded.userNameString)")
        }
        DispatchQueue.main.async {
            store.mode = .start
            self.state = .complete
        }
    }
    
    func getChoiceCount(choice: String, updater: @escaping (String, Int) -> Void) {
        var request = URLRequest(url: config.baseURL.appendingPathComponent(AirtableTables.choices.rawValue).appendingPathComponent(choice))
        request.addValue("Bearer \(config.apiKey)", forHTTPHeaderField: "Authorization")
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let jsonData = data else {
                        print("Server response is \(String(describing: response)). Data could not be decoded.")
                        return
                    }
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(AirtableChoice.self, from: jsonData)
                        if let count = result.fields.count {
                            updater(choice, count)
                        } else {
                        updater(choice, 0)
                        }
                    } catch {
                        print(error)
                    }
                }
                dataTask.resume()
    }
    
    func updateChoiceCount(choice: String, currentCount: Int) {
        var request = URLRequest(url: config.baseURL.appendingPathComponent(AirtableTables.choices.rawValue))
        request.addValue("Bearer \(config.apiKey)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "PATCH"
        let json =
            """
            {
              "records": [
                {
                  "id": "\(choice)",
                  "fields": {
                    "count":\(currentCount + 1)
                  }
                }
              ]
            }
            """.data(using: .utf8)
        request.httpBody = json
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let updateTask = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let jsonData = data else {
                        print("Server response is \(String(describing: response)). Data could not be decoded.")
                        return
                    }
                    do {
                        print(String(describing: jsonData))
                        }
                    catch {
                        print(error)
                    }
                }
                updateTask.resume()
    }
    
    func getDestinationCount(destination: String, updater: @escaping (String, Int) -> Void) {
        var request = URLRequest(url: config.baseURL.appendingPathComponent(AirtableTables.destinations.rawValue).appendingPathComponent(destination))
        request.addValue("Bearer \(config.apiKey)", forHTTPHeaderField: "Authorization")
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let jsonData = data else {
                        print("Server response is \(String(describing: response)). Data could not be decoded.")
                        return
                    }
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(AirtableDestination.self, from: jsonData)
                        if let count = result.fields.count {
                            updater(destination, count)
                        } else {
                        updater(destination, 0)
                        }
                    } catch {
                        print(error)
                    }
                }
                dataTask.resume()
    }
    
    func updateDestinationCount(destination: String, currentCount: Int) {
        var request = URLRequest(url: config.baseURL.appendingPathComponent(AirtableTables.destinations.rawValue))
        request.addValue("Bearer \(config.apiKey)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "PATCH"
        let json =
            """
            {
              "records": [
                {
                  "id": "\(destination)",
                  "fields": {
                    "count":\(currentCount + 1)
                  }
                }
              ]
            }
            """.data(using: .utf8)
        request.httpBody = json
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let updateTask = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let jsonData = data else {
                        print("Server response is \(String(describing: response)). Data could not be decoded.")
                        return
                    }
                    do {
                        print(String(describing: jsonData))
                        }
                    catch {
                        print(error)
                    }
                }
                updateTask.resume()
    }
}

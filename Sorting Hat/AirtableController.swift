//
//  AirtableController.swift
//  Sorting Hat
//
//  Created by Joshua Botts on 3/28/21.
//  Copyright © 2021 Joshua Botts. All rights reserved.
//

import Foundation
import Combine

class AirtableController: ObservableObject {
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
}

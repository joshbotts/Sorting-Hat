//
//  KidSortingView.swift
//  Sorting Hat
//
//  Created by Joshua Botts on 8/30/20.
//  Copyright © 2020 Joshua Botts. All rights reserved.
//

import SwiftUI
import AVKit
import AVFoundation

struct KidSortingView: View {
    @EnvironmentObject var store: SortingStore
    @State var question: Int
    let synthesizer = AVSpeechSynthesizer()
    
    let columns = [GridItem(.adaptive(minimum: 300))]
    
    func getQuestion() -> Int {
        var unaskedQuestions = Dictionary<Int, SortingQuestion>()
        for question in self.store.questions {
            if question.value.asked == 0 && question.value.kidMode {
                unaskedQuestions[question.key] = question.value
            }
        }
        if unaskedQuestions.isEmpty {
            print("No more unasked questions. Time to sort.")
            self.store.sortingResult()
            self.store.mode = SortingStore.Mode.results
        }
        return unaskedQuestions.randomElement()!.key
    }
    
    func scoreQuestion(choice: SortingQuestion.SortingQuestionChoice) {
        self.store.questionScorer(user: self.store.user, question: self.store.questions[question]!, choice: choice)
    }
    
    func refreshView() {
        var unaskedQuestions: [SortingQuestion] = []
        for question in self.store.questions.values {
            if question.asked == 0 {
                unaskedQuestions.append(question)
            }
        }
        if unaskedQuestions.isEmpty || self.store.questionCount > self.store.questionsForSort {
            print("Time to sort!")
            self.store.sortingResult()
            self.store.mode = SortingStore.Mode.results
        } else {
            self.question = self.getQuestion()
            print("The current question is \(self.store.questions[question]?.question ?? "*none*")")
        }
    }
    
    
    
    func speakQuestion() {
        let utterance = AVSpeechUtterance(string: self.store.questions[question]!.question)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        utterance.rate = 0.3
        self.synthesizer.speak(utterance)
    }
    
    // implemented text to speech thanks to Paul Hudson: https://www.hackingwithswift.com/example-code/media/how-to-convert-text-to-speech-using-avspeechsynthesizer-avspeechutterance-and-avspeechsynthesisvoice
    
    func speakChoice(choice: SortingQuestion.SortingQuestionChoice) {
        let utterance = AVSpeechUtterance(string: choice.choiceText)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        utterance.rate = 0.3
        self.synthesizer.speak(utterance)
    }
    var body: some View {
        VStack {
        VStack {
            Button(action: {
                self.speakQuestion()
            }) {
                Text(self.store.questions[question]!.question)
                    .font(.headline)
                    .foregroundColor(Color.black)
                    .lineLimit(nil)
                    .layoutPriority(1)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal, 90)
                    .padding(.vertical, 20)
                    .background(Image(decorative: "paper")
                                    .resizable()
                    )
            }
            .lineLimit(nil)
            .fixedSize(horizontal: false, vertical: true)
            if UIDevice.current.model.contains("iPad") {
                ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .center) {
                    LazyVGrid(columns: columns, content: {
                    ForEach(self.store.questions[question]!.choices, id: \.self.id) { choice in
                        Button(action: {
                            self.scoreQuestion(choice: choice)
                            self.refreshView()
                        })  {
                            Image(uiImage: UIImage(data: FileManager.default.contents(atPath: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(choice.id).relativePath)!)!)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 300, maxHeight: 300)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                })
                }
            }
            } else {
            ScrollView(.horizontal, showsIndicators: true) {
            VStack(alignment: .center) {
            HStack {
                ForEach(self.store.questions[question]!.choices, id: \.self.id) { choice in
                    Button(action: {
                        self.scoreQuestion(choice: choice)
                        self.refreshView()
                    })  {
                        Image(uiImage: UIImage(data: FileManager.default.contents(atPath: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(choice.id).relativePath)!)!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 300, maxHeight: 300)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            }
        }
            }
        }
        .padding(.bottom, 20)
        .background(Image(decorative: "parchment").scaledToFill())
    }
}
}

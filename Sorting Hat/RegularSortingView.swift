//
//  RegularSortingView.swift
//  Sorting Hat
//
//  Created by Joshua Botts on 8/30/20.
//  Copyright © 2020 Joshua Botts. All rights reserved.
//

import SwiftUI
import AVKit
import AVFoundation

struct RegularSortingView: View {
    @EnvironmentObject var store: SortingStore
    @State var question: Int
    let synthesizer = AVSpeechSynthesizer()
    @Environment(\.colorScheme) var colorScheme
    
    func getQuestion() -> Int {
        var unaskedQuestions = Dictionary<Int, SortingQuestion>()
        for question in self.store.questions {
            if question.value.asked == 0 && !question.value.kidMode {
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
                    if store.talkingHat {
                        self.speakQuestion()
                    }
                }) {
                    Text(self.store.questions[question]!.question)
                        .font(.headline)
                        .foregroundColor(Color.black)
                        .lineLimit(nil)
                        .layoutPriority(1)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, 40)
                .padding(.vertical, 20)
                .background(Image(decorative: "paper")
                                .resizable()
                )
            }
            ScrollView {
                ForEach(self.store.questions[question]!.choices, id: \.self.id) { choice in
                    HStack {
                        Spacer()
                        Button(choice.choiceText, action: {
                            self.scoreQuestion(choice: choice)
                            self.refreshView()
                        })
                        .foregroundColor(Color.black)
                        .layoutPriority(2)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 10)
                        .background(Image(decorative: "paper")
                                        .resizable()
                        )
                        Spacer()
                        if self.store.talkingHat == true {
                            Button(action: {
                                self.speakChoice(choice: choice)
                            })
                            {
                                Image(systemName: "speaker.2.fill")
                                
                            }
                            .padding(.horizontal, 10)
                            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                        }
                    }
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 30)
                }
            }
        }
        .padding(.bottom, 20)
        .background(Image(decorative: "parchment").scaledToFill())
    }
}

//struct RegularSortingView_Previews: PreviewProvider {
//    static var previews: some View {
//        RegularSortingView()
//    }
//}

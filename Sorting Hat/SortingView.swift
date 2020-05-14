//
//  SortingView.swift
//  Sorting Hat
//
//  Created by Joshua Botts on 5/5/20.
//  Copyright © 2020 Joshua Botts. All rights reserved.
//

import SwiftUI

struct SortingView: View {
    @ObservedObject var store: SortingStore
    @State var sortingTime: Bool = false
    @State var questionsAsked: Int = 0
    @State var currentQuestion: Int
    
    init(store: SortingStore, question: Int) {
        self._currentQuestion = /*State<Int>*/.init(initialValue: question)
        self.store = store
        print("The Sorting View has received the Sorting Store")
        print("The current question is \(store.questions[self.currentQuestion]!.question)")
    }
    
    func getQuestion() -> Int {
        var unaskedQuestions = Dictionary<Int, SortingQuestion>()
        for question in self.store.questions {
            if question.value.asked == 0 {
                unaskedQuestions[question.key] = question.value
            }
        }
        if unaskedQuestions.isEmpty {
            self.sortingTime = true
            print("No more unasked questions. Time to sort.")
        }
            return unaskedQuestions.randomElement()!.key
    }
    
    func scoreQuestion(choice: SortingQuestion.SortingQuestionChoice) {
        self.store.questionScorer(user: self.store.user, question: self.store.questions[currentQuestion]!, choice: choice)
    }
    
    func refreshView() {
        self.questionsAsked += 1
        var unaskedQuestions: [SortingQuestion] = []
        for question in self.store.questions.values {
            if question.asked == 0 {
                unaskedQuestions.append(question)
            }
        }
        if unaskedQuestions.isEmpty || self.questionsAsked > 4 {
            self.sortingTime = true
            print("Time to sort!")
        } else {
            self.currentQuestion = self.getQuestion()
            print("The current question is \(self.store.questions[currentQuestion]?.question ?? "*none*")")
        }
    }
    
    func sortingResult() -> SortingDestination {
        print("Sorting scores are: \(String(describing: self.store.user.sortingScores))")
        return self.store.user.sortingScores!.max(by: { a, b in a.value < b.value })?.key ?? SortingDestination(name: "Error", description: "The Sorting Hat needs to be fixed.")
    }
    
    var body: some View {
        VStack{
            if sortingTime == false {
                VStack {
                    Text(self.store.questions[currentQuestion]!.question)
                        .font(.headline)
                        .padding()
                    ForEach(self.store.questions[currentQuestion]!.choices, id: \.self.id) { choice in
                        HStack {
                        Text(choice.choiceText)
                        Spacer()
                            Button("Select", action: {
                                    self.scoreQuestion(choice: choice)
                                    self.refreshView()
                            })
                        }.padding()
                    }
                }.padding(.bottom, 50)
            } else {
                VStack {
                    Spacer()
                    Text("Better be...")
                    Spacer()
                    Spacer()
                    Text("\(self.sortingResult().name)!")
                    Spacer()
                    Text(self.sortingResult().description)
                        .font(.caption)
                        .padding()
                    Spacer()
                }
            }
        }.padding()
    }
}
        
//struct ResultsView: View {
//        @ObservedObject var store: SortingStore
//
//        var body: some View {
//        VStack {
//            Text("Better be...")
//            Spacer()
//            Spacer()
//            Text("\(self.sortingResult().name)!")
//            Spacer()
//            Text(self.sortingResult().description)
//        }.navigationBarItems(leading: NavigationLink(destination: ContentView()) {
//                    Text("Start Over")
//                }
//        )
//    }
//
//    func sortingResult() -> SortingDestination {
//        return self.store.user.sortingScores!.max(by: { a, b in a.value < b.value })?.key ?? SortingDestination(name: "Error", description: "The Sorting Hat needs to be fixed.")
//    }
//}
//
//struct QuestionView: View {
//    @ObservedObject var store: SortingStore
//    @Binding var sortingTime: Bool
//
//    var body: some View {
//        VStack {
//            Text(self.getQuestion().question)
//                .font(.headline)
//            ForEach(self.getQuestion().choices, id: \.self.id) { choice in
//                {
//                    Button(action:
//                        {
//                            self.scoreQuestion(choice: choice)
//                            self.refreshView()
//                        }
//                    )
//                    {
//                        Text(choice.choiceText)
//
//                    }
//                }
//            }
//        }
//    }
//
//    func getQuestion() -> SortingQuestion {
//        return self.store.questions[0]
//    }
//
//    func scoreQuestion(choice: SortingQuestion.SortingQuestionChoice) {
//        self.store.questionScorer(user: self.store.user, question: self.getQuestion(), choice: choice)
//    }
//
//    func refreshView() {
//        self.store.questions.remove(at: 0)
//        if self.store.questions.isEmpty {
//            self.sortingTime = true
//        }
//    }
//}

//struct QuestionView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuestionView(question: SortingQuestion())
//    }
//}
//
//struct SortingView_Previews: PreviewProvider {
//    static var previews: some View {
//        SortingView(store: SortingStore())
//    }
//}
//
//struct ResultsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ResultsView(store: SortingStore())
//    }
//}

struct SortingView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}

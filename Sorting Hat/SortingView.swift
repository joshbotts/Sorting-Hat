//
//  SortingView.swift
//  Sorting Hat
//
//  Created by Joshua Botts on 5/5/20.
//  Copyright © 2020 Joshua Botts. All rights reserved.
//

import SwiftUI
import AVFoundation

struct SortingView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var store: SortingStore
    @State var sortingTime: Bool = false
    @State var questionsAsked: Int = 0
    @State var currentQuestion: Int
    var kidsMode: Bool
    var talkingHat: Bool
    
    init(store: SortingStore, question: Int, kidsMode: Bool, talkingHat: Bool) {
        self._currentQuestion = /*State<Int>*/.init(initialValue: question)
        self.store = store
        self.kidsMode = kidsMode
        self.talkingHat = talkingHat
        print("The Sorting View has received the Sorting Store")
        print("The current question is \(store.questions[self.currentQuestion]!.question)")
        print(self.kidsMode ? "The Sorting Hat is in Kid's Mode" : "The Sorting Hat is not in Kid's Mode")
        print(self.talkingHat ? "The Sorting Hat will automatically speak" : "The Sortign Hat will only speak when asked")
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
        return self.store.user.sortingScores!.max(by: { a, b in a.value < b.value })?.key ?? SortingDestination(name: "Error", descriptionFull: "The Sorting Hat needs to be fixed.")
    }
    
    func speakQuestion() {
        let utterance = AVSpeechUtterance(string: self.store.questions[currentQuestion]!.question)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        utterance.rate = 0.3
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
    
    func speakChoice(choice: SortingQuestion.SortingQuestionChoice) {
        let utterance = AVSpeechUtterance(string: choice.choiceText)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        utterance.rate = 0.3
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
    
    var body: some View {
        VStack(alignment: .center) {
            if sortingTime == false {
                if kidsMode == true {
                    VStack {
                        Button(action: {
                            self.speakQuestion()
                        }) {
                            Text(self.store.questions[currentQuestion]!.question)
                                .font(.headline)
                                .lineLimit(nil)
                                .layoutPriority(1)
                                .fixedSize(horizontal: false, vertical: true)
                                .padding(.horizontal, 10)
                                .padding(.bottom, 20)
                        }
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                    }
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack {
                            ForEach(self.store.questions[currentQuestion]!.choices, id: \.self.id) { choice in
                                Button(action: {
                                    self.scoreQuestion(choice: choice)
                                    self.refreshView()
                                })  {
                                    Image(choice.choiceImage!)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxWidth: 300, maxHeight: 300)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
                    .padding(.bottom, 20)
                } else {
                    VStack {
                        VStack {
                            Button(action: {
                                self.speakQuestion()
                            }) {
                                Text(self.store.questions[currentQuestion]!.question)
                                    .font(.headline)
                                    .lineLimit(nil)
                                    .layoutPriority(1)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .padding(.horizontal, 10)
                                    .padding(.bottom, 20)
                            }
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                        }
                        ForEach(self.store.questions[currentQuestion]!.choices, id: \.self.id) { choice in
                            HStack {
                                Button(choice.choiceText, action: {
                                    self.scoreQuestion(choice: choice)
                                    self.refreshView()
                                })
                                    .layoutPriority(2)
                                    .lineLimit(nil)
                                    .fixedSize(horizontal: false, vertical: true)
                                Spacer()
                                if self.talkingHat == true {
                                    Button(action: {
                                        self.speakChoice(choice: choice)
                                    }) { Image(systemName: "speaker.2.fill") }
                                }
                            }
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.horizontal, 10)
                            .padding(.bottom, 20)
                        }
                    }
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
                    .padding(.bottom, 20)
                }
            } else {
                VStack(alignment: .center) {
                    DestinationMovie(player: AVPlayer(url: Bundle.main.url(forResource: self.sortingResult().name, withExtension: "mov")!))
                    Spacer()
                    Text("\(self.store.user.name), you strike me as a...")
                    Spacer()
                    Text(self.sortingResult().name == "Dumbledore's Army" ? "member of \(self.sortingResult().name)!" : "\(self.sortingResult().name)!")
                    Spacer()
                    Text(self.sortingResult().descriptionFull)
                        .font(.caption)
                        .padding()
                    Spacer()
                }
                .padding()
                .navigationBarHidden(false)
                .navigationBarBackButtonHidden(false)
                .navigationBarItems(leading: Button("Sort Again?") {
                    self.presentationMode.wrappedValue.dismiss()
                })
            }
        }
        .frame(maxWidth: 700, alignment: .center)
    }
}

struct DestinationMovie: View, UIViewRepresentable {
    let player: AVPlayer
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<DestinationMovie>) {
        player.play()
    }
    func makeUIView(context: Context) -> UIView {
        return PlayerUIView(player: player)
    }
}

class PlayerUIView: UIView {
    let playerLayer = AVPlayerLayer()
    init(player: AVPlayer) {
        super.init(frame: .zero)
        
        playerLayer.player = player
        layer.addSublayer(playerLayer)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}

//struct SortingView_Previews: PreviewProvider {
//    static var previews: some View {
//        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
//    }
//}

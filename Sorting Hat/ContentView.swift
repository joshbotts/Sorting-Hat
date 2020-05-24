//
//  ContentView.swift
//  Sorting Hat
//
//  Created by Joshua Botts on 4/15/20.
//  Copyright © 2020 Joshua Botts. All rights reserved.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @State var userName: String = ""
    @ObservedObject var store = SortingStore()
    @State var storeSet: Bool = false
    //    @Environment(\.colorScheme) var colorScheme
    let textFieldPlaceholderText = "Enter your name and press return."
    @State var kidsMode: Bool = false
    @ObservedObject private var keyboard = KeyboardResponder()
    @State var talkingHat: Bool = false
    
    func speakSortingHat() {
        let utterance = AVSpeechUtterance(string: "Oh, yes. \(self.userName). Let's sort you out.")
        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        utterance.rate = 0.3
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
    
    func textSortingHat() {
        self.userName = "Ahhhh, yes. Let's sort you out."
    }
    
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .center) {
                    Image("sorting-hat")
                        .resizable()
                        .scaledToFit()
                }
                VStack {
                    TextField(self.textFieldPlaceholderText, text: self.$userName, onCommit: {
                        self.kidsMode ? self.store.setKidStore(user: self.userName) : self.store.setStore(user: self.userName);
                        self.storeSet = true
                        print("User \(self.userName) is set. The Sorting Store has loaded these questions: \(self.store.questions.values.map({$0.question}))")
                        self.talkingHat ? self.speakSortingHat() : self.textSortingHat()
                    })
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                    if self.storeSet == false {
                        Toggle(isOn: self.$kidsMode) {
                            Text("Want to use Kid's Mode?")
                        }
                        .font(.body)
                        Toggle(isOn: self.$talkingHat) {
                            Text("Want the Hat to speak?")
                        }
                        .font(.body)
                    }
                }
                .padding()
                .padding(.bottom, keyboard.currentHeight)
                .edgesIgnoringSafeArea(.bottom)
                .animation(.easeOut(duration: 0.16))
                //                .background(colorScheme == .dark ? Color.black : Color.white)
                HStack {
                    Spacer()
                    if self.storeSet == true {
                        Button("Reset the Sorting Hat",
                               action: {
                                self.userName = ""
                                self.store.resetStore()
                                self.storeSet = false
                        }
                        )
                            .font(.body)
                    }
                }
                .padding(10)
                VStack(alignment: .center) {
                    if self.storeSet == true {
                        Spacer()
                        NavigationLink(destination: SortingView(store: self.store, question: self.store.questions.keys.randomElement()!, kidsMode: self.kidsMode, talkingHat: self.talkingHat)) {
                            Text("Begin the Sorting!")
                                .font(.headline)
                        }
                        .isDetailLink(false)
                        //                .background(colorScheme == .dark ? Color.black : Color.white)
                    }
                }
                .padding()
                .frame(maxWidth: 700, alignment: .center)
            }
            .padding()
        }
        .padding()
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class KeyboardResponder: ObservableObject {
    private var notificationCenter: NotificationCenter
    @Published private(set) var currentHeight: CGFloat = 0
    
    init(center: NotificationCenter = .default) {
        notificationCenter = center
        notificationCenter.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        notificationCenter.removeObserver(self)
    }
    
    @objc func keyBoardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            currentHeight = keyboardSize.height
        }
    }
    
    @objc func keyBoardWillHide(notification: Notification) {
        currentHeight = 0
    }
}

// implemented view response to keyboard activation from https://stackoverflow.com/a/58242249/12259419

//
//  StartingView.swift
//  Sorting Hat
//
//  Created by Joshua Botts on 9/11/20.
//  Copyright © 2020 Joshua Botts. All rights reserved.
//

import SwiftUI
import AVFoundation

struct StartingView: View {
    @EnvironmentObject var store: SortingStore
    @State var userName: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                VStack {
                    VStack(alignment: .center) {
                        Image("sorting-hat")
                            .resizable()
                            .scaledToFit()
                    }
                    VStack(alignment: .center) {
                        TextField("Put me on! Don't be afraid!", text: self.$userName, onCommit: {
                            self.store.kidsMode ? self.store.setKidStore(user: self.userName) : self.store.setStore(user: self.userName);
                            print("User \(self.userName) is set. The Sorting Store has loaded these questions: \(self.store.questions.values.map({$0.question}))")
                            self.store.mode = SortingStore.Mode.sort
                        })
                        .font(.title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                        .padding(.horizontal, 20)
                    }
                    VStack(alignment: .leading) {
                        Text("Enter your name and press return.")
                            .font(.body)
                    }
                }
                Spacer()
                VStack {
                    VStack(alignment: .center) {
                        VStack {
                            Text("Current sort settings:")
                                .font(.subheadline)
                                .foregroundColor(Color.black)
                            HStack {
                                Text("Kid's Mode:")
                                    .font(.caption)
                                    .foregroundColor(Color.black)
                                Text(self.store.kidsMode ? "✔️" : "❌")
                                    .font(.caption)
                                    .foregroundColor(Color.black)
                            }
                            HStack {
                                Text("Talking Hat:")
                                    .font(.caption)
                                    .foregroundColor(Color.black)
                                Text(self.store.talkingHat ? "✔️" : "❌")
                                    .font(.caption)
                                    .foregroundColor(Color.black)
                            }
                            HStack {
                                Text("Questions:")
                                    .font(.caption)
                                    .foregroundColor(Color.black)
                                Text(String(self.store.questionsForSort + 1))
                                    .font(.caption)
                                    .foregroundColor(Color.black)
                            }
                            VStack(alignment: .center) {
                                Button("Change these settings",
                                       action: {
                                        self.store.mode = SortingStore.Mode.settings
                                       })
                                    .font(.subheadline)
                                    .foregroundColor(Color.blue)
                            }
                        }
                    }
                    .padding(50)
                }
                .background(Image(decorative: "paper")
                                .resizable()
                )
                Spacer()
            }
            .background(Image(decorative: "parchment").opacity(0.6).scaledToFill())
        }
    }
}

struct StartingView_Previews: PreviewProvider {
    static var previews: some View {
        StartingView()
    }
}

//class KeyboardResponder: ObservableObject {
//    private var notificationCenter: NotificationCenter
//    @Published private(set) var currentHeight: CGFloat = 0
//
//    init(center: NotificationCenter = .default) {
//        notificationCenter = center
//        notificationCenter.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//        notificationCenter.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
//
//    deinit {
//        notificationCenter.removeObserver(self)
//    }
//
//    @objc func keyBoardWillShow(notification: Notification) {
//        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
//            currentHeight = keyboardSize.height
//        }
//    }
//
//    @objc func keyBoardWillHide(notification: Notification) {
//        currentHeight = 0
//    }
//}

// implemented view response to keyboard activation from https://stackoverflow.com/a/58242249/12259419

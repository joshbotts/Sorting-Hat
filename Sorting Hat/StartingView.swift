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
    @Environment(\.colorScheme) var colorScheme
    @State var userName: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                VStack {
                    VStack(alignment: .center) {
                        Image("sorting hat")
                            .resizable()
                            .scaledToFit()
                    }
                    VStack(alignment: .center) {
                        TextField("Put me on! Don't be afraid!", text: self.$userName, onCommit: {
                            self.store.loadSortingStore(user: userName)
                            print("User \(self.userName) is set. The Sorting Store has loaded these questions: \(self.store.questions.values.map({$0.question}))")
                            self.store.mode = SortingStore.Mode.sort
                        })
                        .font(.title)
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                        .background(Color.white)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                        .padding(.horizontal, 20)
                    }
                    VStack(alignment: .leading) {
                        Text("Enter your name and press return.")
                            .font(.headline)
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
            .background(Image(decorative: "parchment").scaledToFill())
        }
    }
}

struct StartingView_Previews: PreviewProvider {
    static var previews: some View {
        StartingView()
    }
}

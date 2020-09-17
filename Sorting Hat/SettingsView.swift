//
//  SettingsView.swift
//  Sorting Hat
//
//  Created by Joshua Botts on 8/31/20.
//  Copyright © 2020 Joshua Botts. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var store: SortingStore
    @State var questionsToAsk: Int
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                Text("Do you want to use Kid's Mode?")
                    .font(.headline)
                Text("The Sorting Hat will show images as choices for each question and will synthesize the text of questions into speech when you click on them.")
                    .font(.body)
                }
                Spacer()
                Button(self.store.kidsMode ? "No" : "Yes", action: {
                    self.store.kidsMode.toggle()
                })
            }.padding()
            if !self.store.kidsMode {
            HStack {
                VStack(alignment: .leading) {
                Text("Do you want to use the Talking Hat?")
                    .font(.headline)
                Text("The Sorting Hat will synthesize the text of questions and choices when you click on them (for questions) or the buttons next to them (for choices).")
                    .font(.body)
                }
                Spacer()
                Button(self.store.talkingHat ? "No" : "Yes", action: {
                    self.store.talkingHat.toggle()
                })
            }.padding()
            }
            HStack {
                VStack(alignment: .leading) {
                Text("How many questions do you want to answer before you are sorted?")
                    .lineLimit(4)
                    .font(.headline)
                }
                Spacer()
                Picker("Questions:", selection: $questionsToAsk) {
                    ForEach(1..<21) { number in
                        Text(String(number))
                            .font(.body)
                    }
                }
                .labelsHidden()
                .frame(width: 30, height: 80)
                .clipped()
            }.padding()
            HStack {
                Text("Kid's Mode:")
                    .font(.caption)
                Text(self.store.kidsMode ? "✔️" : "❌")
                    .font(.caption)
                Spacer()
                Text("Talking Hat:")
                    .font(.caption)
                Text(self.store.talkingHat ? "✔️" : "❌")
                    .font(.caption)
                Spacer()
                Text("Questions:")
                    .font(.caption)
                Text(String(self.questionsToAsk + 1))
                    .font(.caption)
            }.padding()
            Button("Return to the Sorting Hat", action: {
                    self.store.questionsForSort = questionsToAsk
                    self.store.mode = SortingStore.Mode.start })
        }
    }
}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//    }
//}

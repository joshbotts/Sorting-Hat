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
    @State var kidsMode: Bool
    @State var talkingHat: Bool
    @State var explainKidsMode: Bool = false
    @State var explainTalkingHat: Bool = false
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                VStack {
                    Toggle(isOn: $kidsMode, label: {
                        Button(action: {
                            explainKidsMode.toggle()
                            
                        }, label: {
                            Text("Use Kid's Mode?")
                        }
                        )
                    })
                    .padding(.horizontal, 40)
                    if explainKidsMode {
                        Text("The Sorting Hat will show images as choices for each question and will synthesize the text of questions into speech when you click on them.")
                            .font(.caption2)
                            .foregroundColor(Color.black)
                    }
                }
                .padding(.horizontal, 90)
                .padding(.vertical, 20)
                .background(Image(decorative: "paper")
                                .resizable()
                )
                VStack {
                Toggle(isOn: $talkingHat, label: {
                    Button(action: {
                        explainTalkingHat.toggle()
                    }, label: {
                        Text("Use Talking Hat mode?")
                    })
                })
                .padding(.horizontal, 40)
                if explainTalkingHat {
                    Text("The Sorting Hat will synthesize the text of questions and choices when you click on them (for questions) or the buttons next to them (for choices).")
                        .font(.caption2)
                        .foregroundColor(Color.black)
                }
            }
                .padding(.horizontal, 90)
                .padding(.vertical, 20)
            .background(Image(decorative: "paper")
                            .resizable()
            )
            }
            HStack {
                Spacer()
                VStack(alignment: .leading) {
                    Text("How many questions do you want to answer before you are sorted?")
                        .lineLimit(4)
                        .font(.body)
                        .foregroundColor(Color.black)
                }
                Spacer()
                Spacer()
                Picker("Questions:", selection: $questionsToAsk) {
                    ForEach(1..<21) { number in
                        Text(String(number))
                            .font(.body)
                            .foregroundColor(Color.black)
                    }
                }
                .labelsHidden()
                .frame(width: 30, height: 80)
                .clipped()
                Spacer()
            }
            .padding(.horizontal, 90)
            .padding(.vertical, 20)
            .background(Image(decorative: "paper")
                            .resizable()
            )
            Link("Suggest a new sorting question", destination: URL(string: "https://airtable.com/shrNAVEKBOOEustpG")!)
                .padding(.horizontal, 90)
                .padding(.vertical, 20)
                .background(Image(decorative: "paper")
                                .resizable()
                )
            Link("View Source Code on GitHub", destination: URL(string: "https://github.com/joshbotts/Sorting-Hat/")!)
                .font(.caption)
                .padding(.horizontal, 90)
                .padding(.vertical, 20)
                .background(Image(decorative: "paper")
                                .resizable()
                )
            Link("View Source Data on Airtable", destination: URL(string: "https://airtable.com/invite/l?inviteId=invKAaewa7LbKW80n&inviteToken=a6360616462a543566787cc2123c158c160b1a6506dbbb1c36afa66b0674a3fe")!)
                .font(.caption)
                .padding(.horizontal, 90)
                .padding(.vertical, 20)
                .background(Image(decorative: "paper")
                                .resizable()
                )
            Button("Return to the Sorting Hat", action: {
                    self.store.kidsMode = kidsMode
                    self.store.talkingHat = talkingHat
                    self.store.questionsForSort = questionsToAsk
                    self.store.mode = SortingStore.Mode.start })
                .padding(.horizontal, 90)
                .padding(.vertical, 20)
                .background(Image(decorative: "paper")
                                .resizable()
                )
        }
        .background(Image(decorative: "parchment").scaledToFill())
    }
}

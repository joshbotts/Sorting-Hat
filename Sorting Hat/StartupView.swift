//
//  StartupView.swift
//  Sorting Hat
//
//  Created by Joshua Botts on 3/23/21.
//  Copyright © 2021 Joshua Botts. All rights reserved.
//

import SwiftUI
import AVKit
import AVFoundation

struct StartupView: View {
    @EnvironmentObject var store: SortingStore
    @EnvironmentObject var airtable: AirtableLoader
    let splashMovie = AVPlayer(url: Bundle.main.url(forResource: "sorting hat 3", withExtension: "mov")!)
    
    var body: some View {
        VStack {
            Spacer()
            Text("The Sorting Hat")
                .font(.title)
                .foregroundColor(Color.black)
                .padding(40)
                .background(Image(decorative: "paper")
                                .resizable()
                )
            Spacer()
            if !UIDevice.current.model.contains("iPad") {
            VideoPlayer(player: splashMovie)
                .onAppear( perform: { splashMovie.play()
                    airtable.loadBase()
                } )
                .frame(width: 360, height: 240, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            } else {
                VideoPlayer(player: splashMovie)
                    .onAppear( perform: { splashMovie.play()
                        airtable.loadBase()
                    } )
                    .frame(minWidth: 720, maxWidth: 900, minHeight: 480, maxHeight: 600, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
            if airtable.state == .baseLoaded {
                Button("Start") {
                    airtable.transcodeBase(store: store)
                }
                .foregroundColor(Color.black)
                .padding(20)
                .background(Image(decorative: "paper")
                                .resizable()
                )
            } else {
                Text("Loading")
                    .foregroundColor(Color.black)
                .padding(20)
                .background(Image(decorative: "paper")
                                .resizable()
                )
            }
            (Spacer())
            Text("This application is for entertainment purposes only. No guarantee of admission to Hogwarts or assignment to any particular house is expressed or implied.")
                .font(.caption)
                .foregroundColor(Color.black)
                .padding(.horizontal, 90)
                .padding(.vertical, 20)
                .background(Image(decorative: "paper")
                                .resizable()
                )
        }
        .background(Image(decorative: "parchment").scaledToFill())
    }
}

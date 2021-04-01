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
    let splashMovie = AVPlayer(url: Bundle.main.url(forResource: "sorting hat 2", withExtension: "mov")!)
    
    var body: some View {
        VideoPlayer(player: splashMovie)
            .onAppear( perform: { splashMovie.play()
                airtable.loadBase()
            } )
            .frame(width: 360, height: 240, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        Button("Start") {
            airtable.baseToStore(store: store)
        }
    }
}

struct StartupView_Previews: PreviewProvider {
    static var previews: some View {
        StartupView()
    }
}

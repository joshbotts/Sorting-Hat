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
    let splashMovie = AVPlayer(url: Bundle.main.url(forResource: "sorting hat", withExtension: "mov")!)
    @State var dataLoaded: Bool = false
    
    var body: some View {
        VideoPlayer(player: splashMovie)
            .onAppear( perform: { splashMovie.play() } )
            .frame(width: 360, height: 240, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        if dataLoaded {
            Button("Start") { store.mode = SortingStore.Mode.start }
        } else {
            Text("Loading data")
        }
    }
}

struct StartupView_Previews: PreviewProvider {
    static var previews: some View {
        StartupView()
    }
}

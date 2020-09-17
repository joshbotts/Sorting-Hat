//
//  SortingResultView.swift
//  Sorting Hat
//
//  Created by Joshua Botts on 8/30/20.
//  Copyright © 2020 Joshua Botts. All rights reserved.
//

import SwiftUI
import AVKit
import AVFoundation

struct SortingResultView: View {
    @EnvironmentObject var store: SortingStore
    
    var body: some View {
        VStack(alignment: .center) {
            VideoPlayer(player: store.movie!)
                .onAppear( perform: { self.store.movie?.play() } )
            Spacer()
            Text("\(self.store.user.name), you strike me as a...")
            Spacer()
            Text(self.store.destination!.name == "Dumbledore's Army" ? "member of \(self.store.destination!.name)!" : "\(self.store.destination!.name)!")
            Spacer()
            Text(self.store.destination!.descriptionFull)
                .font(.caption)
                .foregroundColor(Color.black)
                .padding(40)
                .background(Image(decorative: "paper")
                                .resizable()
                )
            Spacer()
            Button("Sort again?", action: {
                    self.store.resetStore()
            })
            .padding(15)
            .background(Image(decorative: "paper")
                            .resizable()
            )
        }
        .padding()
        .background(Image(decorative: "parchment").opacity(0.6).scaledToFill())
    }
}

struct SortingResultView_Previews: PreviewProvider {
    static var previews: some View {
        SortingResultView()
    }
}

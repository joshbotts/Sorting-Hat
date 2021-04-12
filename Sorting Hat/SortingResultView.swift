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
    @EnvironmentObject var airtable: AirtableLoader
    
    var body: some View {
        VStack(alignment: .center) {
            if !UIDevice.current.model.contains("iPad") {
                VideoPlayer(player: store.movie!)
                    .onAppear( perform: {
                        self.airtable.getDestinationCount(destination: self.store.destination!.id, updater: self.airtable.updateDestinationCount)
                                self.store.movie?.play()
                    } )
                .frame(width: 360, height: 240, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            } else {
                VideoPlayer(player: store.movie!)
                    .onAppear( perform: {
                        self.airtable.getDestinationCount(destination: self.store.destination!.id, updater: self.airtable.updateDestinationCount)
                                self.store.movie?.play()
                    } )
                    .frame(minWidth: 720, maxWidth: 900, minHeight: 480, maxHeight: 600, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
            Spacer()
            VStack(alignment: .center) {
                Text("\(self.store.user.name), you strike me as a...")
                    .font(.headline)
                Text(self.store.destination!.name == "Dumbledore's Army" ? "member of \(self.store.destination!.name)!" : "\(self.store.destination!.name)!")
                    .font(.headline)
            }
            .foregroundColor(Color.black)
            .padding(.horizontal, 90)
            .padding(.vertical, 20)
            .background(Image(decorative: "paper")
                            .resizable()
            )
            Spacer()
            Text(self.store.destination!.descriptionFull)
                .font(.caption)
                .foregroundColor(Color.black)
                .padding(.horizontal, 90)
                .padding(.vertical, 20)
                .background(Image(decorative: "paper")
                                .resizable()
                )
            Spacer()
            Button("Sort again?", action: {
                self.store.resetStore()
            })
            .padding(20)
            .background(Image(decorative: "paper")
                            .resizable()
            )
        }
        .padding()
        .background(Image(decorative: "parchment").scaledToFill())
    }
}

struct SortingResultView_Previews: PreviewProvider {
    static var previews: some View {
        SortingResultView()
    }
}

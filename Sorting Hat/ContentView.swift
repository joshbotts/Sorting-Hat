//
//  ContentView.swift
//  Sorting Hat
//
//  Created by Joshua Botts on 4/15/20.
//  Copyright © 2020 Joshua Botts. All rights reserved.
//

import SwiftUI
import Combine
import AVFoundation

struct ContentView: View {
    @EnvironmentObject var store: SortingStore
    
    var body: some View {
        switch self.store.mode {
        case SortingStore.Mode.start:
            StartingView()
        case SortingStore.Mode.settings:
            SettingsView(questionsToAsk: self.store.questionsForSort)
        case SortingStore.Mode.sort:
            SortingView()
        case SortingStore.Mode.results:
            SortingResultView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


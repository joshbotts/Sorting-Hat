//
//  SortingView.swift
//  Sorting Hat
//
//  Created by Joshua Botts on 5/5/20.
//  Copyright © 2020 Joshua Botts. All rights reserved.
//

import SwiftUI
import Combine
import AVFoundation
import AVKit

struct SortingView: View {
    @EnvironmentObject var store: SortingStore
    @State var sortingTime: Bool = false

    func getKidsQuestion() -> Int {
        var question = self.store.questions.keys.randomElement()!
        while !self.store.questions[question]!.kidMode {
            question = self.store.questions.keys.randomElement()!
        }
        return question
    }
    
    func getNonKidsQuestion() -> Int {
        var question = self.store.questions.keys.randomElement()!
        while self.store.questions[question]!.kidMode {
            question = self.store.questions.keys.randomElement()!
        }
        return question
    }
    
    var body: some View {
        switch self.store.kidsMode {
        case true:
            KidSortingView(question: self.getKidsQuestion())
        case false:
            RegularSortingView(question: self.getNonKidsQuestion())
        }
    }
}

struct SortingView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}

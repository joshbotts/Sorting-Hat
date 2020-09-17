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

    var body: some View {
        switch self.store.kidsMode {
        case true:
            KidSortingView(question: self.store.questions.keys.randomElement()!)
        case false:
            RegularSortingView(question: self.store.questions.keys.randomElement()!)
        }
    }
}

struct SortingView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}

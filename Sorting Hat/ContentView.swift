//
//  ContentView.swift
//  Sorting Hat
//
//  Created by Joshua Botts on 4/15/20.
//  Copyright © 2020 Joshua Botts. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var userName: String = ""
    @ObservedObject var store = SortingStore()
    @State var storeSet: Bool = false
    @Environment(\.colorScheme) var colorScheme
    
    init(){
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                        Image("sorting-hat")
                            .resizable()
                            .scaledToFit()
                }
                Form {
                    TextField("Please type your name then press 'return.'", text: self.$userName, onCommit: {
                        self.store.setStore(user: self.userName);
                        self.storeSet = true;
                        print("User \(self.userName) is set. The Sorting Store has loaded these questions: \(self.store.questions.values.map({$0.question}))") })
                            .padding()
                if self.storeSet == true {
                    NavigationLink(destination: SortingView(store: self.store, question: self.store.questions.keys.randomElement()!)) {
                            Text("Begin the Sorting!")
                            }
                        }
                }.background(colorScheme == .dark ? Color.black : Color.white)
            }.padding(.bottom, 200)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

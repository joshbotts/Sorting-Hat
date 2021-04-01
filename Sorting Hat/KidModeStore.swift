//
//  KidModeStore.swift
//  Sorting Hat
//
//  Created by Joshua Botts on 5/29/20.
//  Copyright © 2020 Joshua Botts. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

extension SortingStore {
    func setKidStore(user: String) {
        self.user = User(user)
        print("User \(user) has been added to the Sorting Store.")
        self.loadSortingStore(user: user)
        print("Scores for destinations have been set for \(user)")
    }
}

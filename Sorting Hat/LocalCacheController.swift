//
//  LocalCacheController.swift
//  Sorting Hat
//
//  Created by Joshua Botts on 3/28/21.
//  Copyright © 2021 Joshua Botts. All rights reserved.
//

import Foundation


class LocalCacheController {
    let localStorage: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
}


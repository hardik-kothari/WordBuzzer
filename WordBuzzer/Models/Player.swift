//
//  Player.swift
//  WordBuzzer
//
//  Created by Hardik Kothari on 1/9/2562 BE.
//  Copyright © 2562 Hardik Kothari. All rights reserved.
//

import Foundation

struct Player {
    var name: String
    var correctAnswers: Int
    
    init(name: String) {
        self.name = name
        correctAnswers = 0
    }
    
    mutating func correctAnswer() {
        correctAnswers += 1
    }
}

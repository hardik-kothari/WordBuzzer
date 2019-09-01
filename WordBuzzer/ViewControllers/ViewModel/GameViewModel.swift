//
//  GameViewModel.swift
//  WordBuzzer
//
//  Created by Hardik Kothari on 1/9/2562 BE.
//  Copyright © 2562 Hardik Kothari. All rights reserved.
//

import Foundation

class PuzzleViewModel {
    let word: Translation
    private let answers: [Translation]
    
    init(_ word: Translation, answers: [Translation]) {
        self.word = word
        self.answers = answers
    }
}

extension PuzzleViewModel {
    func numberOfAnswers() -> Int {
        return answers.count
    }
    
    func answerAtIndex(_ index: Int) -> Translation {
        return answers[index]
    }
}

class GameViewModel {
    private var puzzles: [PuzzleViewModel] = []
    
    init() {
        preparePuzzles()
    }
    
    private func preparePuzzles() {
        let totalWords = GameServices.shared.allTranslations.count
        var randomWordIndexes: [Int] = []
        while randomWordIndexes.count < GameServices.shared.numberOfPuzzles {
            let newIndex = Int.random(in: 0..<totalWords)
            if !randomWordIndexes.contains(newIndex) {
                randomWordIndexes.append(newIndex)
            }
        }
        puzzles = randomWordIndexes.map({ wordIndex in
            let word = GameServices.shared.allTranslations[wordIndex]
            var randomIndexesForOptions: [Int] = []
            while randomIndexesForOptions.count < (GameServices.shared.numberOfOptionsPerPuzzle - 1) {
                let newIndex = Int.random(in: 0..<totalWords)
                if !randomIndexesForOptions.contains(newIndex) && newIndex != wordIndex {
                    randomIndexesForOptions.append(newIndex)
                }
            }
            let randomIndexForAnswer = Int.random(in: 0..<GameServices.shared.numberOfOptionsPerPuzzle)
            randomIndexesForOptions.insert(wordIndex, at: randomIndexForAnswer)
            let answers = randomIndexesForOptions.map({ answerIndex in
                return GameServices.shared.allTranslations[answerIndex]
            })
            return PuzzleViewModel(word, answers: answers)
        })
    }
}

extension GameViewModel {
    func numberOfPuzzles() -> Int {
        return puzzles.count
    }
    
    func puzzleAtIndex(_ index: Int) -> PuzzleViewModel {
        return puzzles[index]
    }
}

//
//  GameViewController.swift
//  WordBuzzer
//
//  Created by Hardik Kothari on 1/9/2562 BE.
//  Copyright © 2562 Hardik Kothari. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var lblPuzzleNumber: UILabel!
    @IBOutlet weak var lblWord: UILabel!
    @IBOutlet weak var answerView: UIView!
    @IBOutlet weak var answerViewCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblAnswer: UILabel!
    @IBOutlet weak var lblPuzzleResult: UILabel!
    @IBOutlet weak var correctAnswerView: UIView!
    @IBOutlet weak var lblCorrectAnswer: UILabel!
    
    @IBOutlet weak var lblPlayer1Name: UILabel!
    @IBOutlet weak var btnBuzzer1: UIButton!
    @IBOutlet weak var lblPlayer2Name: UILabel!
    @IBOutlet weak var btnBuzzer2: UIButton!
    
    // MARK: - Private properties
    private var viewModel = GameViewModel()
    private var player1 = Player(name: "Hardik Kothari")
    private var player2 = Player(name: "Charmy Mehta")
    private var puzzleIndex: Int = 0
    private var answerIndex: Int = 0
    private var buzzerPressed: Bool = false
    
    // MARK: - Life-cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startGame()
    }
    
    // MARK: - Action methods
    @IBAction func buzzerAction(_ sender: Any) {
        buzzerPressed = true
        showPuzzleResult()
    }
    
    // MARK: - Game methods
    private func startGame() {
        lblPlayer1Name.text = player1.name
        lblPlayer2Name.text = player2.name
        loadPuzzle(puzzleIndex)
    }
    
    @objc private func showNextPuzzle() {
        puzzleIndex += 1
        loadPuzzle(puzzleIndex)
    }
    
    private func loadPuzzle(_ index: Int) {
        if index < viewModel.numberOfPuzzles() {
            answerIndex = 0
            let puzzle = viewModel.puzzleAtIndex(index)
            fadeOutAnswer {}
            fadeOutCorrectAnswer { [unowned self] in
                self.lblPuzzleNumber.text = "Puzzle (\(index + 1)/\(self.viewModel.numberOfPuzzles()))"
                self.lblWord.text = puzzle.word.english
                self.lblCorrectAnswer.text = puzzle.word.spanish
                self.loadAnswer(self.answerIndex)
            }
        }
    }
    
    @objc private func showNextAnswer() {
        answerIndex += 1
        loadAnswer(answerIndex)
    }
    
    private func loadAnswer(_ index: Int) {
        let puzzle = viewModel.puzzleAtIndex(puzzleIndex)
        if index < puzzle.numberOfAnswers() {
            let answer = puzzle.answerAtIndex(index)
            fadeOutAnswer { [unowned self] in
                self.fadeInAnswer(answer)
            }
        } else {
            showPuzzleResult()
        }
    }
    
    private func fadeInAnswer(_ answer: Translation) {
        lblAnswer.text = answer.spanish
        answerView.layoutIfNeeded()
        answerViewCenterConstraint.constant = view.frame.width + answerView.frame.width
        UIView.animate(withDuration: 0.0, delay: 0.0, options: [], animations: { [unowned self] in
            self.view.layoutIfNeeded()
            }, completion: { (completed) in
                self.answerViewCenterConstraint.constant = 0
                UIView.animate(withDuration: 1.0, delay: 0.0, options: [], animations: { [unowned self] in
                    self.answerView.alpha = 1.0
                    self.view.layoutIfNeeded()
                    }, completion: { [unowned self] (completed) in
                        self.perform(#selector(self.showNextAnswer), with: nil, afterDelay: 2.0)
                })
        })
    }
    
    private func fadeOutAnswer(_ completion: @escaping(() -> Void)) {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [], animations: { [unowned self] in
            self.answerView.alpha = 0.0
            }, completion: { (completed) in
                completion()
        })
    }
    
    private func fadeOutCorrectAnswer(_ completion: @escaping(() -> Void)) {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [], animations: { [unowned self] in
            self.lblPuzzleResult.alpha = 0.0
            self.correctAnswerView.alpha = 0.0
            }, completion: { (completed) in
                completion()
        })
    }
    
    private func showPuzzleResult() {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(showNextAnswer), object: nil)
        if buzzerPressed {
            let puzzle = viewModel.puzzleAtIndex(puzzleIndex)
            let selectedAnswer = puzzle.answerAtIndex(answerIndex)
            lblPuzzleResult.alpha = 1.0
            if puzzle.word == selectedAnswer {
                lblPuzzleResult.textColor = UIColor(named: "AppGreen")
                lblPuzzleResult.text = "Correct"
            } else {
                lblPuzzleResult.textColor = UIColor(named: "AppRed")
                lblPuzzleResult.text = "Incorrect"
                correctAnswerView.alpha = 1.0
            }
        } else {
            correctAnswerView.alpha = 1.0
        }
        perform(#selector(showNextPuzzle), with: nil, afterDelay: 2.0)
    }
}

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
    @IBOutlet weak var lblAnswer: UILabel!
    @IBOutlet weak var lblPuzzleResult: UILabel!
    
    @IBOutlet weak var lblPlayer1Name: UILabel!
    @IBOutlet weak var btnBuzzer1: UIButton!
    @IBOutlet weak var lblPlayer2Name: UILabel!
    @IBOutlet weak var btnBuzzer2: UIButton!
    
    // MARK: - Private properties
    private var viewModel = GameViewModel()
    private var player1 = Player(name: "Hardik Kothari")
    private var player2 = Player(name: "Charmy Mehta")

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
    }
    
    // MARK: - Game methods
    private func startGame() {
        lblPlayer1Name.text = player1.name
        lblPlayer2Name.text = player2.name
    }
}

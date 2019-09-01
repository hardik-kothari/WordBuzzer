//
//  ResultViewController.swift
//  WordBuzzer
//
//  Created by Hardik Kothari on 1/9/2562 BE.
//  Copyright © 2562 Hardik Kothari. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var lblResult: UILabel!
    @IBOutlet weak var lblWinnerName: UILabel!
    
    // MARK: - Private properties
    private var winner: Player?
    
    // MARK: - Life-cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let winner = winner {
            lblResult.text = "WINNER!"
            lblWinnerName.text = winner.name
            lblWinnerName.isHidden = false
        } else {
            lblResult.text = "DRAW!"
            lblWinnerName.isHidden = true
        }
    }
}

extension ResultViewController {
    static func storyboardInstance(_ winner: Player?) -> ResultViewController {
        let resultViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ResultViewController")
            as! ResultViewController
        resultViewController.winner = winner
        return resultViewController
    }
}

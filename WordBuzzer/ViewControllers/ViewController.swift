//
//  ViewController.swift
//  WordBuzzer
//
//  Created by Hardik Kothari on 1/9/2562 BE.
//  Copyright © 2562 Hardik Kothari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print(GameServices.shared.allTranslations.count)
    }
}

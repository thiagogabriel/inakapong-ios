//
//  SendScoreViewController.swift
//  inakaPong
//
//  Created by El gera de la gente on 8/4/17.
//  Copyright © 2017 Inaka. All rights reserved.
//

import UIKit

class SendScoreViewController: UIViewController {

    var score: Int!
    
    @IBOutlet weak var scoreLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scoreLabel.text = "\(score!)"
    }

    @IBAction func submitScore(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
}

//
//  MenuViewController.swift
//  inakaPong
//
//  Created by El gera de la gente on 8/4/17.
//  Copyright © 2017 Inaka. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class MenuViewController: UIViewController, UploadScoreProtocol {

    @IBOutlet weak var gameView: SKView!
    @IBOutlet weak var menuButton: UIButton!
    var score: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gameView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.gameView.scene != nil {
            self.menuButton.isHidden = true
            self.gameView.isHidden = true
            self.gameView.presentScene(nil)
        }
    }
    
    func finishGameWithScore(score: Int) {
        self.score = score
        self.performSegue(withIdentifier: "sendScoreSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? SendScoreViewController {
            vc.score = self.score
        }
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        self.menuButton.isHidden = true
        self.gameView.isHidden = true
        self.gameView.presentScene(nil)
    }
    @IBAction func startSinglePlayerGame(_ sender: UIButton) {
        self.gameView.isHidden = false
        self.menuButton.isHidden = false
        if let singlePlayerScene = GKScene(fileNamed: "SinglePlayerGameScene") {
            
            // Get the SKScene from the loaded GKScene
            if let singlePlayerSceneNode = singlePlayerScene.rootNode as! SinglePlayerGameScene? {
                singlePlayerSceneNode.scoreDelegate = self
                // Copy gameplay related content over to the scene
                singlePlayerSceneNode.entities = singlePlayerScene.entities
                singlePlayerSceneNode.graphs = singlePlayerScene.graphs
                
                // Set the scale mode to scale to fit the window
                singlePlayerSceneNode.scaleMode = .aspectFill
                
                // Present the scene
                self.gameView.presentScene(singlePlayerSceneNode)
                self.gameView.ignoresSiblingOrder = false
                self.gameView.allowsTransparency = true
            }
        }
    }
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

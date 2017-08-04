//
//  GameScene.swift
//  inakaPong
//
//  Created by El gera de la gente on 8/4/17.
//  Copyright © 2017 Inaka. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    var gameOn = false
    var paddle: SKSpriteNode!
    var ball: SKSpriteNode!
    
    override func sceneDidLoad() {
        self.paddle = self.childNode(withName: "paddle") as! SKSpriteNode
        self.ball = self.childNode(withName: "ball") as! SKSpriteNode
    }
    
    func startGame() {
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        self.physicsBody = border
        self.ball.physicsBody?.applyImpulse(CGVector(dx: (Int(arc4random_uniform(100)) * Int(-1.0)), dy: 30))
    }
    
    func touchDown(atPoint pos : CGPoint) {
        if !self.gameOn { return }
        
        self.paddle.run(SKAction.moveTo(x: pos.x, duration: 0.2))
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        self.paddle.run(SKAction.moveTo(x: pos.x, duration: 0.2))
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if !self.gameOn {
            self.startGame()
            self.gameOn = true
            return
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        if self.ball.position.y <= ( self.paddle.position.y - 15 ) {
            self.physicsBody = nil
            print ( "GAME OVER")
        }
    }
}

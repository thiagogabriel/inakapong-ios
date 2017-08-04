//
//  SinglePlayerGameScene.swift
//  inakaPong
//
//  Created by El gera de la gente on 8/4/17.
//  Copyright © 2017 Inaka. All rights reserved.
//

import SpriteKit
import GameplayKit

class SinglePlayerGameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    var gameOn = false
    var paddle: SKSpriteNode!
    var ball: SKSpriteNode!
    var background: SKSpriteNode!
    
    override func sceneDidLoad() {
        let backgroundMusic = SKAudioNode(fileNamed: "background-music.mp3")
        backgroundMusic.autoplayLooped = true
        addChild(backgroundMusic)
        self.paddle = self.childNode(withName: "paddle") as! SKSpriteNode
        self.ball = self.childNode(withName: "ball") as! SKSpriteNode
        self.background = self.childNode(withName: "background") as! SKSpriteNode
        self.background.zPosition = 0
        self.paddle.zPosition = 1
        self.ball.zPosition = 1
    }
    
    func startGame() {
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        self.physicsBody = border
        self.ball.physicsBody?.applyImpulse(CGVector(dx: (Int(arc4random_uniform(100)) * Int(-1.0)), dy: 85))
    }
    
    func movePaddleTo(_ pos: CGPoint) {
        let margin = self.paddle.size.width/2
        let rightScreenBorder = self.frame.size.width/2
        let leftScreenBorder = rightScreenBorder * -1
        
        if pos.x < leftScreenBorder + margin {
            self.paddle.run(SKAction.moveTo(x: leftScreenBorder + margin, duration: 0.05))
        }else if pos.x > rightScreenBorder - margin {
            self.paddle.run(SKAction.moveTo(x: rightScreenBorder - margin, duration: 0.05))
        }else {
            self.paddle.run(SKAction.moveTo(x: pos.x, duration: 0.05))
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        if !self.gameOn { return }

        self.movePaddleTo(pos)
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if !self.gameOn { return }
        
        self.movePaddleTo(pos)
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
        if self.ball.position.y <= ( self.paddle.position.y - 15 ) && self.gameOn == true {
            self.gameOn = false
            self.physicsBody = nil
            //present the send score screen
        }
    }
}

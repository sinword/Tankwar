//
//  gameOverScene.swift
//  tankWar
//
//  Created by  陳奕軒 on 2023/6/7.
//

import UIKit
import SpriteKit

class gameOverScene: SKScene {
    override func didMove(to view:SKView){
        createScene()
    }
    
    var winner = "Player"
    
    func createScene(){
        let bgd = SKSpriteNode(color: SKColor.black, size: self.size)
        bgd.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        bgd.zPosition = -1
        
        if self.winner == "Player 1"{
            bgd.color = SKColor.systemPink
        }
        else if self.winner == "Player 2"{
            bgd.color = SKColor.systemMint
        }
        
        let winnerLbl = SKLabelNode(text: "\(winner)")
        winnerLbl.name = "winnerLbl"
        winnerLbl.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 50)
        winnerLbl.fontName = "Avenir-Oblique"
        winnerLbl.fontSize = 60
        
        let lbl = SKLabelNode(text: "wins")
        lbl.name = "lbl"
        lbl.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 50)
        lbl.fontName = "Avenir-Oblique"
        lbl.fontSize = 60
        
        self.addChild(bgd)
        self.addChild(winnerLbl)
        self.addChild(lbl)
        
        self.run(SKAction.wait(forDuration: 5)){
            let menuScene = menuScene(size: self.size)
            let fade = SKTransition.fade(withDuration: 3)
            self.view?.presentScene(menuScene, transition: fade)
        }
    }
}

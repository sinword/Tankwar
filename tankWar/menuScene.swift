//
//  menuScene.swift
//  tankWar
//
//  Created by  陳奕軒 on 2023/4/2.
//

import UIKit
import SpriteKit
import GameplayKit

class menuScene: SKScene{
    override func didMove(to view: SKView) {
        createScene()
    }
    
    func createScene() {
        let bkg = SKSpriteNode(imageNamed: "menuBkg")
        bkg.size.width = self.size.width
        bkg.size.height = self.size.height
        bkg.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        bkg.zPosition = -1
        bkg.alpha = 0.5
        
        let helloLbl = SKLabelNode(text: "Tank war")
        helloLbl.name = "label"
        helloLbl.position = CGPoint(x: self.frame.midX, y: self.frame.midY / 2 * 3)
        helloLbl.fontName = "Avenir-Oblique"
        helloLbl.fontSize = 28
        
        for i in 1...3{
            let level = SKSpriteNode(color: UIColor.white, size: CGSize(width: 200, height: 50))
            level.name = "level \(i)"
            level.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 100 - 100.0 * CGFloat(i))
            level.zPosition = 0
            
            let levelIndicator = SKLabelNode(text: level.name)
            levelIndicator.name = "level \(i)"
            levelIndicator.fontColor = UIColor.black
            levelIndicator.position =  CGPoint(x: 0, y: -7.5)
            levelIndicator.fontName = "Avenir-Oblique"
            levelIndicator.fontSize = 20
            levelIndicator.zPosition = 1
            
            level.addChild(levelIndicator)
            self.addChild(level)
        }
        
        
        self.addChild(bkg)
        self.addChild(helloLbl)
        
        let backgroundSound = SKAudioNode(fileNamed: "./musics/cyber-war.mp3")
        self.addChild(backgroundSound)
        backgroundSound.run(SKAction.play())
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first!
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)

        if let name = touchedNode.name
        {
            for i in 1...3{
                let node = self.childNode(withName: "level \(i)")
                node?.run(SKAction.removeFromParent())
            }
            
            let labelNode = self.childNode(withName: "label")
            let movedown = SKAction.moveBy(x: 0, y: -200, duration: 1)
            let zoomin = SKAction.scale(to: 3.0, duration: 1)
            let pause = SKAction.wait(forDuration: 0.5)
            let spin = SKAction.rotate(byAngle: 2 * .pi, duration: 0.5)
            let fadeaway = SKAction.fadeOut(withDuration: 0.25)
            let remove = SKAction.removeFromParent()
            let moveseq = SKAction.sequence([movedown, zoomin, pause, spin, fadeaway, remove])
            
            labelNode?.run(moveseq, completion: {
                let mainScene = mainScene(size: self.size)
                mainScene.levelSel = name
                let doors = SKTransition.doorsOpenVertical(withDuration: 1)
                self.view?.presentScene(mainScene, transition: doors)
            })
        }
    }
}

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
    
    func createScene(){
        let bkg = SKSpriteNode(imageNamed: "menuBkg")
        bkg.size.width = self.size.width
        bkg.size.height = self.size.height
        bkg.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        bkg.zPosition = -1
        bkg.alpha = 0.5
        
        let helloLbl = SKLabelNode(text: "Tank war")
        helloLbl.name = "label"
        helloLbl.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        helloLbl.fontName = "Avenir-Oblique"
        helloLbl.fontSize = 28
        
        self.addChild(bkg)
        self.addChild(helloLbl)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let labelNode = self.childNode(withName: "label")
        let moveup = SKAction.moveBy(x: 0, y: 200, duration: 1)
        let zoomin = SKAction.scale(to: 3.0, duration: 1)
        let pause = SKAction.wait(forDuration: 0.5)
        let zoomout = SKAction.scale(to: 0.5, duration: 0.25)
        let fadeaway = SKAction.fadeOut(withDuration: 0.25)
        let remove = SKAction.removeFromParent()
        let moveseq = SKAction.sequence([moveup, zoomin, pause, zoomout, fadeaway, remove])
        labelNode?.run(moveseq, completion: {
            let mainScene = mainScene(size: self.size)
            let doors = SKTransition.doorsOpenVertical(withDuration: 0.5)
            self.view?.presentScene(mainScene, transition: doors)
        })
    }
}

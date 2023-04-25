//
//  mainScene.swift
//  tankWar
//
//  Created by  陳奕軒 on 2023/4/2.
//

import UIKit
import SpriteKit
import GameController

class mainScene: SKScene {
    let mContainer = MapContainer()
    
    private var _virtualController: Any?
    public var virtualController: GCVirtualController? {
        get { return self._virtualController as? GCVirtualController }
        set { self._virtualController = newValue }
    }
    override func didMove(to view: SKView) {
        createScene()
        mContainer.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        addChild(mContainer)
        mContainer.onInit(mapName: "map1")
    }
    
    var playersTank = [Tank]()
    
    func createScene() {
        let mainbkg = SKSpriteNode(imageNamed: "mainBkg")
        mainbkg.size.width = self.size.width
        mainbkg.size.height = self.size.height
        mainbkg.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        mainbkg.zPosition = -1
        
        let p1tank = Tank(name: "p1")
        p1tank.position = CGPoint(x: self.frame.midX, y: self.frame.maxY + self.frame.midY / 3 - self.frame.midY)
        p1tank.myStick.position = CGPoint(x: self.frame.minX + self.frame.midX / 2, y: self.frame.maxY - self.frame.midY / 3)
        playersTank.append(p1tank)
        
        let p2tank = Tank(name: "p2")
        p2tank.position = CGPoint(x: self.frame.midX, y: self.frame.minY - self.frame.midY / 3 + self.frame.midY)
        p2tank.myStick.position = CGPoint(x: self.frame.midX + self.frame.midX / 2, y: self.frame.minY + self.frame.midY / 3)
        playersTank.append(p2tank)
        
        p1tank.fireButton.position = CGPoint(x: self.frame.midX + self.frame.midX / 2, y: self.frame.maxY - self.frame.midY / 3)
        p1tank.abilityButton.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - self.frame.midY / 3)
        
        p2tank.fireButton.position = CGPoint(x: self.frame.midX - self.frame.midX / 2, y: self.frame.minY + self.frame.midY / 3)
        p2tank.abilityButton.position = CGPoint(x: self.frame.midX, y: self.frame.minY + self.frame.midY / 3)
        
        
        //應該可以優化
        self.addChild(mainbkg)
        self.addChild(p1tank)
        self.addChild(p2tank)
        self.addChild(p1tank.myStick)
        self.addChild(p2tank.myStick)
        self.addChild(p1tank.fireButton)
        self.addChild(p1tank.abilityButton)
        self.addChild(p2tank.fireButton)
        self.addChild(p2tank.abilityButton)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let posInScene = touch.location(in: self)
        let touchedNode = self.nodes(at: posInScene).first!
    
        if let name = touchedNode.name{
            if name == "1 fire" {
                print("p1 fire")
                playersTank[0].tankFire(tankPosition: playersTank[0].position)
            }
            else if name == "1 ability" {
                print("p1 ability")
            }
            else if name == "2 fire" {
                print("p2 fire")
                // touchedNode.tankFire(playersTank[0])
            }
            else if name == "2 ability" {
                print("p2 ability")
            }
        }
        
        super.touchesBegan(touches, with: event)
    }
    
    
}

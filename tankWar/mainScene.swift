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
    
    func createScene(){
        let mainbkg = SKSpriteNode(imageNamed: "mainBkg")
        mainbkg.size.width = self.size.width
        mainbkg.size.height = self.size.height
        mainbkg.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        mainbkg.zPosition = -1
        
        let p1tank = Tank()
        p1tank.setName(name: "p1")
        p1tank.position = CGPoint(x: self.frame.midX, y: self.frame.maxY + self.frame.midY / 3 - self.frame.midY)
        playersTank.append(p1tank)
        
        let p2tank = Tank()
        p2tank.setName(name: "p2")
        p2tank.position = CGPoint(x: self.frame.midX, y: self.frame.minY - self.frame.midY / 3 + self.frame.midY)
        p2tank.zRotation = 2
        playersTank.append(p2tank)
        
        
        
        self.addChild(mainbkg)
        self.addChild(p1tank)
        self.addChild(p2tank)
    }
    
    
}

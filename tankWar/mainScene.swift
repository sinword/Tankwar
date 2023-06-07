//
//  mainScene.swift
//  tankWar
//
//  Created by  陳奕軒 on 2023/4/2.
//

import UIKit
import SpriteKit
import GameController

class mainScene: SKScene, SKPhysicsContactDelegate {
    let mContainer = MapContainer()
    var levelSel = "level 1"
    
    private var _virtualController: Any?
    public var virtualController: GCVirtualController? {
        get { return self._virtualController as? GCVirtualController }
        set { self._virtualController = newValue }
    }
    override func didMove(to view: SKView) {
        createScene()
        mContainer.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        addChild(mContainer)
        switch levelSel{
        case "level 1":
            mContainer.onInit(mapName: "map1")
        case "level 2":
            mContainer.onInit(mapName: "map2")
        case "level 3":
            mContainer.onInit(mapName: "map3")
        default:
            mContainer.onInit(mapName: "map1")
        }
        
        physicsWorld.contactDelegate = self
    }
    
    var playersTank = [Tank]()
    
    func createScene() {
        let mainbkg = SKSpriteNode(imageNamed: "mainBkg")
        mainbkg.size.width = self.size.width
        mainbkg.size.height = self.size.height
        mainbkg.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        mainbkg.zPosition = -1
        
        let p1tank = Tank(name: "p1")
        p1tank.position = CGPoint(x: self.frame.midX, y: self.frame.maxY + self.frame.midY / 2 - self.frame.midY)
        p1tank.myStick.position = CGPoint(x: self.frame.minX + self.frame.midX / 2, y: self.frame.maxY - self.frame.midY / 3)
        playersTank.append(p1tank)
        
        let p2tank = Tank(name: "p2")
        p2tank.position = CGPoint(x: self.frame.midX, y: self.frame.minY - self.frame.midY / 2 + self.frame.midY)
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
                let ball = CannonBall(type: "fire", owner: 1)
                self.playersTank[0].tankAtk(ball: ball, atkType: "fire")
                self.addChild(ball)
            }
            else if name == "1 ability" {
                let ball = CannonBall(type: "ability", owner: 1)
                self.playersTank[0].tankAtk(ball: ball, atkType: "ability")
                self.addChild(ball)
                print("p1 ability")
            }
            else if name == "2 fire" {
                print("p2 fire")
                let ball = CannonBall(type: "fire", owner: 2)
                self.playersTank[1].tankAtk(ball: ball, atkType: "fire")
                self.addChild(ball)
            }
            else if name == "2 ability" {
                let ball = CannonBall(type: "ability", owner: 2)
                self.playersTank[1].tankAtk(ball: ball, atkType: "ability")
                self.addChild(ball)
                print("p2 ability")
            }
        }
        
        super.touchesBegan(touches, with: event)
    }
    
    func handleWin(){
        var winner = "Empty"
        if self.playersTank[0].lifePoint == 0{
            winner = "Player 1"
        }
        else if self.playersTank[1].lifePoint == 0{
            winner = "Player 2"
        }
        
        if winner != "Empty"{
            let gameOverScene = gameOverScene(size: self.size)
            gameOverScene.winner = winner
            view?.presentScene(gameOverScene)
        }
    }
    
    // View of cannon
    func didBegin(_ contact: SKPhysicsContact) {
        // Body A -> map object / tank
        // Body B -> bullet
        if let firstBody = contact.bodyA.node as? MapObject{
            if let bullet = contact.bodyB.node as? CannonBall{
                switch firstBody.myType {
                    case .Wall:
                    if bullet.myType == "fire"{
                        bullet.doCollision()
                        firstBody.getDamaged()
                    }
                    
                    case .Brick:
                    if bullet.myType == "fire"{
                        bullet.doCollision()
                        firstBody.getDamaged()
                    }
                    
                    case .Box:
                    if bullet.myType == "fire"{
                        bullet.run(SKAction.removeFromParent())
                        firstBody.getDamaged()
                    }
                    
                    case .Brush:
                    if bullet.myType == "fire"{
                        bullet.run(SKAction.removeFromParent())
                    }
                    
                    case .River:
                    break
                    
                    case .Empty:
                    break
                
                }
            }
        }
        else if let firstBody = contact.bodyA.node as? Tank{
            if let bullet = contact.bodyB.node as? CannonBall{
                if bullet.owner != firstBody.myCode{
                    firstBody.getDamaged()
                    bullet.run(SKAction.removeFromParent())
                }
            }
        }
        self.handleWin()
    }
    
}

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
    let abilitySound = SKAction.playSoundFileNamed("./musics/tank_ability.wav", waitForCompletion: false)
    let fireSound = SKAction.playSoundFileNamed("./musics/tank_attack.wav", waitForCompletion: false)
    
    
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
            mContainer.onInit(mapName: "map1", size: self.frame.size)
        case "level 2":
            mContainer.onInit(mapName: "map2", size: self.frame.size)
        case "level 3":
            mContainer.onInit(mapName: "map3", size: self.frame.size)
        default:
            mContainer.onInit(mapName: "map1", size: self.frame.size)
        }
        
        physicsWorld.contactDelegate = self
        
        let backgroundSound = SKAudioNode(fileNamed: "./musics/the-epic-trailer.mp3")
        self.addChild(backgroundSound)
        backgroundSound.run(SKAction.play())
    }
    
    var playersTank = [Tank]()
    
    func createScene() {
        let mainbkg = SKSpriteNode(imageNamed: "mainBkg")
        mainbkg.size.width = self.size.width
        mainbkg.size.height = self.size.height
        mainbkg.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        mainbkg.zPosition = -1
        
        let p1tank = Tank(name: "p1", mainScene: self)
        p1tank.position = CGPoint(x: self.frame.midX, y: self.frame.maxY + self.frame.midY / 2 - self.frame.midY)
        p1tank.myStick.position = CGPoint(x: self.frame.minX + self.frame.midX / 2, y: self.frame.maxY - self.frame.midY / 3)
        playersTank.append(p1tank)
        
        let p2tank = Tank(name: "p2", mainScene: self)
        p2tank.position = CGPoint(x: self.frame.midX, y: self.frame.minY - self.frame.midY / 2 + self.frame.midY)
        p2tank.myStick.position = CGPoint(x: self.frame.midX + self.frame.midX / 2, y: self.frame.minY + self.frame.midY / 3)
        playersTank.append(p2tank)
        
        p1tank.fireButton.position = CGPoint(x: self.frame.midX + self.frame.midX / 2, y: self.frame.maxY - self.frame.midY / 3)
        p1tank.abilityButton.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - self.frame.midY / 3)
        
        p2tank.fireButton.position = CGPoint(x: self.frame.midX - self.frame.midX / 2, y: self.frame.minY + self.frame.midY / 3)
        p2tank.abilityButton.position = CGPoint(x: self.frame.midX, y: self.frame.minY + self.frame.midY / 3)
        
        
        //應該可以優化
        self.addChild(mainbkg)
        self.addChild(p1tank.myStick)
        self.addChild(p2tank.myStick)
        self.addChild(p1tank.fireButton)
        self.addChild(p1tank.abilityButton)
        self.addChild(p2tank.fireButton)
        self.addChild(p2tank.abilityButton)
        self.addChild(p1tank)
        self.addChild(p2tank)

    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let posInScene = touch.location(in: self)
        let touchedNode = self.nodes(at: posInScene).first!
    
        if let name = touchedNode.name{
            if name == "1 fire" {
                if let node = touchedNode as? JoystickButton{
                    print("p1 fire")
                    if node.isReady{
                        let ball = CannonBall(type: "fire", owner: 1)
                        self.playersTank[0].tankAtk(ball: ball, atkType: "fire")
                        self.addChild(ball)
                        self.run(self.fireSound)
                        node.isReady = false
                        node.run(SKAction.setTexture(SKTexture(imageNamed: "Fire_cooldown")))
                        node.run(SKAction.wait(forDuration: 1)){
                            node.run(SKAction.setTexture(SKTexture(imageNamed: "fire")))
                            node.isReady = true
                        }
                    }
                }
            }
            else if name == "1 ability" {
                print("p1 ability")
                if let node = touchedNode as? JoystickButton{
                    if node.isReady{
                        let ball = CannonBall(type: "ability", owner: 1)
                        self.playersTank[0].tankAtk(ball: ball, atkType: "ability")
                        self.addChild(ball)
                        self.run(self.fireSound)
                        node.isReady = false
                        //node.run(SKAction.setTexture(SKTexture(imageNamed: "Ability_cooldown")))
                        node.run(SKAction.wait(forDuration: 1.5)){
                            //node.run(SKAction.setTexture(SKTexture(imageNamed: "ability")))
                            node.isReady = true
                        }
                    }
                }
            }
            else if name == "2 fire" {
                print("p2 fire")
                if let node = touchedNode as? JoystickButton{
                    if node.isReady{
                        let ball = CannonBall(type: "fire", owner: 2)
                        self.playersTank[1].tankAtk(ball: ball, atkType: "fire")
                        self.addChild(ball)
                        self.run(self.fireSound)
                        node.isReady = false
                        node.run(SKAction.setTexture(SKTexture(imageNamed: "Fire_cooldown")))
                        node.run(SKAction.wait(forDuration: 1)){
                            node.run(SKAction.setTexture(SKTexture(imageNamed: "fire")))
                            node.isReady = true
                        }
                    }
                }
            }
            else if name == "2 ability" {
                if let node = touchedNode as? JoystickButton{
                    if node.isReady{
                        let ball = CannonBall(type: "ability", owner: 2)
                        self.playersTank[1].tankAtk(ball: ball, atkType: "ability")
                        self.addChild(ball)
                        self.run(self.fireSound)
                        node.isReady = false
                        //node.run(SKAction.setTexture(SKTexture(imageNamed: "Ability_cooldown")))
                        node.run(SKAction.wait(forDuration: 1.5)){
                            //node.run(SKAction.setTexture(SKTexture(imageNamed: "ability")))
                            node.isReady = true
                        }
                    }
                }
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
            self.removeAllChildren()
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
        
        else if let firstBody = contact.bodyA.node as? CannonBall{
            if let bullet = contact.bodyB.node as? CannonBall{
                if bullet.owner != firstBody.owner && bullet.myType == firstBody.myType{
                    firstBody.run(SKAction.removeFromParent())
                    bullet.run(SKAction.removeFromParent())
                }
            }
        }
        //self.handleWin()
    }
    
}

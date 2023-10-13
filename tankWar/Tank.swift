//
//  Tank.swift
//  tankWar
//
//  Created by  陳奕軒 on 2023/4/14.
//

import UIKit
import SpriteKit

class Tank: SKSpriteNode {
    let mySize = CGSize(width: 25, height: 25)
    var myCode = 0
    var myStick = AnalogJoystick(diameter: 80, colors: (UIColor.blue, UIColor.black))
    var fireButton: JoystickButton
    var abilityButton: JoystickButton
    var lifePoint = 10
    var healthBar = SKSpriteNode(color: UIColor.red, size: CGSize(width: 40, height: 10))
    var healthBarBk = SKSpriteNode(color: UIColor.black, size: CGSize(width: 40, height: 10))
    var mainScene: mainScene
    
    
    init(name: String, mainScene: mainScene){
        let texture: SKTexture
        self.mainScene = mainScene
        if name == "p1"{
            texture = SKTexture(imageNamed: "p1Tank")
            self.myCode = 1
        }
        else{
            texture = SKTexture(imageNamed: "p2Tank")
            self.myCode = 2
        }
        self.fireButton = JoystickButton(name: "fire", owner: self.myCode)
        self.abilityButton = JoystickButton(name: "ability", owner: self.myCode)

        super.init(texture: texture, color: UIColor.clear, size: mySize)
        
        self.name = name
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/2)
        self.physicsBody?.restitution = 1
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.affectedByGravity = false
        
        self.physicsBody?.categoryBitMask = 0x1 << 1
        self.physicsBody?.collisionBitMask =  0x1 << 1 | 0x1 << 3 | 0x1 << 4
        
        self.healthBar.xScale = Double(self.lifePoint) / 10
        self.healthBar.anchorPoint = CGPointMake(0.0, 0.5)
        self.healthBar.position = CGPoint(x: -20, y: -20)
        self.healthBarBk.position = CGPoint(x: 0, y: -20)
        self.healthBar.zPosition = 5
        self.healthBarBk.zPosition = 4
        self.addChild(self.healthBarBk)
        self.addChild(self.healthBar)
        
        if name == "p1" {
            self.myStick.substrate.color = UIColor.blue
        }
        else if name == "p2" {
            self.myStick.substrate.color = UIColor.red
            self.zRotation = .pi
        }
        
        self.myStick.trackingHandler = { [weak self] data in
            if var pos = self?.position{
                pos.x = pos.x + data.velocity.x * 0.075
                pos.y = pos.y + data.velocity.y * 0.075
                self?.zRotation = .pi + data.angular
                if let boundary = self?.parent?.frame{
                    if pos.x >= boundary.minX && pos.x <= boundary.maxX{
                        if pos.y >= boundary.minY && pos.y <= boundary.maxY{
                            self?.position = pos
                        }
                    }
                }
            }
        }
    }

    
    func updateHealthBar(){
        self.healthBar.xScale = Double(self.lifePoint) / 10
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented ")
    }
    
    func getName()->String {
        return self.name!
    }
    
    func getStick()->AnalogJoystick{
        return self.myStick
    }
    
    func tankAtk(ball: CannonBall, atkType: String){
        ball.position = self.position
        ball.zRotation = self.zRotation
        if atkType == "fire"{
            ball.fire()
        }
        else{
            ball.ability()
        }
    }
    
    func getDamaged(){
        self.lifePoint -= 1
        self.updateHealthBar()
        self.mainScene.handleWin()
    }
}

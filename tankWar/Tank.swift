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
    var myStick = AnalogJoystick(diameter: 50, colors: (UIColor.blue, UIColor.black))
    var fireButton: attackButton
    var abilityButton: attackButton
    var lifePoint = 10
    
    init(name: String){
        let texture: SKTexture
        
        if name == "p1"{
            texture = SKTexture(imageNamed: "p1Tank")
            self.fireButton = attackButton(name: "fire", owner: 1)
            self.abilityButton = attackButton(name: "ability", owner: 1)
        }
        else{
            texture = SKTexture(imageNamed: "p2Tank")
            self.fireButton = attackButton(name: "fire", owner: 2)
            self.abilityButton = attackButton(name: "ability", owner: 2)
        }
        super.init(texture: texture, color: UIColor.clear, size: mySize)
        
        self.name = name
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/2)
        self.physicsBody?.restitution = 1
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.affectedByGravity = false
        
        if name == "p1" {
            self.myStick.substrate.color = UIColor.blue
        }
        else if name == "p2" {
            self.myStick.substrate.color = UIColor.red
            self.zRotation = .pi
        }
        
        self.myStick.trackingHandler = { [unowned self] data in
            var pos = self.position
            pos.x = pos.x + data.velocity.x * 0.075
            pos.y = pos.y + data.velocity.y * 0.075
            self.zRotation = .pi + data.angular
            self.position = pos
        }
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
    
    func tankFire(tankPosition: CGPoint) {
        // var bounce : Int = 0
        let cannonSpeed : Float = 200
        let cannonBall = SKSpriteNode(texture: SKTexture(imageNamed: "cannonball"))
        cannonBall.size = CGSize(width: 20, height: 20)
        let direction = self.myStick.getVelocity()
        let velocity = CGVector(dx: direction.x * CGFloat(cannonSpeed), dy: direction.y * CGFloat(cannonSpeed))
        print("velocity: \(velocity)")
        cannonBall.physicsBody?.applyImpulse(velocity, at: tankPosition)
        cannonBall.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        cannonBall.physicsBody?.affectedByGravity = false
        cannonBall.physicsBody?.isDynamic = true
        cannonBall.physicsBody?.usesPreciseCollisionDetection = true
        // cannonBall.physicsBody?.velocity = CGVector(dx: 0, dy: 100)
        cannonBall.physicsBody?.categoryBitMask = 0x1 << 1
        cannonBall.physicsBody?.collisionBitMask = 0b1 << 2
        self.addChild(cannonBall)
    }
}

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
        
        if name == "p1"{
            self.myStick.substrate.color = UIColor.blue
        }
        else if name == "p2"{
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
    
    required init?(coder aDecoder: NSCoder){
        fatalError("init(coder: ) has not been implemented ")
    }
    
    func getName()->String{
        return self.name!
    }
    
    func getStick()->AnalogJoystick{
        return self.myStick
    }
}

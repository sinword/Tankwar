//
//  CannonBall.swift
//  tankWar
//
//  Created by  陳奕軒 on 2023/4/23.
//

import UIKit
import SpriteKit

class CannonBall: SKSpriteNode {
    let mySize = CGSize(width: 15, height: 15)
    var isBounced = false
    var owner: Int
    var myType: String
    init(type:String, owner: Int) {
        self.myType = type
        self.owner = owner
        let texture: SKTexture
        if (self.myType == "fire") {
            texture = SKTexture(imageNamed: "cannon ball")
        }
        else {
            texture = SKTexture(imageNamed: "cannon ball")
        }
        
        super.init(texture: texture, color: UIColor.clear, size: mySize)
        self.name = self.myType
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width / 2)
        self.physicsBody?.restitution = 1
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.affectedByGravity = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

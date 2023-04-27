//
//  CannonBall.swift
//  tankWar
//
//  Created by  陳奕軒 on 2023/4/23.
//

import UIKit
import SpriteKit

class CannonBall: SKSpriteNode {
    let mySize = CGSize(width: 12, height: 12)
    let travelDistance = CGFloat(2000)
    let wallDistance = CGFloat(40)
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
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = 0x1 << 1
        self.physicsBody?.collisionBitMask = 0x1 << 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fire() {
        let move = SKAction.move(
            to: CGPointMake(
                travelDistance * cos(self.zRotation - .pi / 2) + self.position.x,
                travelDistance * sin(self.zRotation - .pi / 2) + self.position.y
               ),
           duration: 4)
        let moveAction = SKAction.sequence([
            move
        ])
        self.run(moveAction)
    }
    
    func ability(){
        let zoomout = SKAction.scale(by: 0.5, duration: 0.1)
        let move = SKAction.move(
            to: CGPointMake(
                self.wallDistance * cos(self.zRotation - .pi / 2) + self.position.x,
                self.wallDistance * sin(self.zRotation - .pi / 2) + self.position.y
               ),
           duration: 1)
        let zoomin = SKAction.scale(by: 2, duration: 0.1)
        let remove = SKAction.removeFromParent()
        let moveAction = SKAction.sequence([zoomin, move, zoomout, remove])
        self.run(moveAction)
    }
    
}

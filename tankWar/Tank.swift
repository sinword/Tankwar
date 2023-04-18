//
//  Tank.swift
//  tankWar
//
//  Created by  陳奕軒 on 2023/4/14.
//

import UIKit
import SpriteKit

class Tank: SKSpriteNode {
    override init(texture: SKTexture?, color:SKColor, size:CGSize){
        let texture = SKTexture(imageNamed: "p1Tank")
        super.init(texture:texture, color:SKColor.clear, size:texture.size())
        self.zPosition = 2
        self.size = CGSize(width: 25, height: 25)
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/2)
        self.physicsBody?.restitution = 1
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.affectedByGravity = false
    }
    required init?(coder aDecoder: NSCoder){
        fatalError("init(coder: ) has not been implemented ")
    }
    func setName(name:String){
        self.name = name
        if self.name == "p1"{
            self.texture = SKTexture(imageNamed: "p1Tank")
        }
        if self.name == "p2"{
            self.texture = SKTexture(imageNamed: "p2Tank")
        }
    }
}

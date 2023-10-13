//
//  CannonBall.swift
//  tankWar
//
//  Created by  陳奕軒 on 2023/4/23.
//

import UIKit
import SpriteKit

class CannonBall: SKSpriteNode {
    let mySize = CGSize(width: 20, height: 20)
    let travelDistance = CGFloat(2000)
    let wallDistance = CGFloat(60)
    let secondOfSpeed = 8.0
    var isBounced = false
    var owner: Int
    var myType: String
    var originPos = CGPoint(x: 0, y: 0)
    var counter = 0
    
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
        self.zPosition = 2
        
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width / 2)
        self.physicsBody?.restitution = 1
        //self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.affectedByGravity = false
        //self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = 0x1 << 2
        if (self.myType == "fire") {
            self.physicsBody?.contactTestBitMask = 0x1 << 1 | 0x1 << 2 | 0x1 << 3
        }
        self.physicsBody?.collisionBitMask = 0x1 << 9
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fire(){
        let move = SKAction.move(
            to: CGPointMake(
                travelDistance * cos(self.zRotation - .pi / 2) + self.position.x,
                travelDistance * sin(self.zRotation - .pi / 2) + self.position.y
               ),
            duration: self.secondOfSpeed)
        let moveAction = SKAction.sequence([
            move
        ])
        self.originPos = self.position
        
        self.run(moveAction){
        }
    }
    
    
    
    func ability(){
        let zoomout = SKAction.scale(by: 0.5, duration: 0.3)
        let move = SKAction.move(
            to: CGPointMake(
                self.wallDistance * cos(self.zRotation - .pi / 2) + self.position.x,
                self.wallDistance * sin(self.zRotation - .pi / 2) + self.position.y
               ),
           duration: 1)
        let zoomin = SKAction.scale(by: 2, duration: 0.2)
        let remove = SKAction.removeFromParent()
        let moveAction = SKAction.sequence([zoomin, move, zoomout])
        self.run(moveAction){
            if let nodes = self.parent?.nodes(at: self.position){
                for node in nodes{
                    if let curr_node = node as? MapObject{
                        curr_node.getDamaged()
                    }
                    else if let curr_node = node as? Tank{
                        if self.owner != curr_node.myCode{
                            curr_node.getDamaged()
                        }
                    }
                    else if let curr_node = node as? CannonBall{
                        if self.owner != curr_node.owner{
                            curr_node.run(SKAction.removeFromParent())
                        }
                    }
                }
            }
            self.run(remove)
        }
        
    }
    
    
    
    func doCollision(){
        if self.isBounced{
            self.run(SKAction.removeFromParent())
        }
        else{
            doBounce()
            self.isBounced = true
        }
    }
    
    func doBounce(){
        if sin(self.zRotation) <= -(1/sqrt(2)) || sin(self.zRotation) >= 1/sqrt(2){
            let actionReversed = SKAction.move(
                to: CGPointMake(
                    -(travelDistance * cos(self.zRotation - .pi / 2) + self.originPos.x),
                    2 * travelDistance * sin(self.zRotation - .pi / 2) + self.originPos.y
                ),
                duration: self.secondOfSpeed)
            self.run(actionReversed)
        }
        else{
            let actionReversed = SKAction.move(
                to: CGPointMake(
                    2 * travelDistance * cos(self.zRotation - .pi / 2) + self.originPos.x,
                    -(travelDistance * sin(self.zRotation - .pi / 2) + self.originPos.y)
                ),
                duration: self.secondOfSpeed)
            self.run(actionReversed)
        }
    }
}

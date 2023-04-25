//
//  MapObject.swift
//  tankWar
//
//  Created by  陳奕軒 on 2023/4/14.
//

import UIKit
import SpriteKit

enum objectType : Int {
    case Wall = 0
    case Brick = 1
    case Box = 2
    case River = 3
    case Brush = 4
    case Empty = 5
}

class MapObject: SKSpriteNode {
    let mySize = CGSize(width: 35, height: 35)
    var myType = objectType.Wall
    var durability = -1
    var index = 0
    var canRebound = false
    var canBreak = false
    
    init(type: objectType, index: Int = 0) {
        self.myType = type
        self.index = index
        let texture: SKTexture
        switch myType {
            case .Wall:
                texture = SKTexture(imageNamed: "wall")
                self.canRebound = true
            case .Brick:
                texture = SKTexture(imageNamed: "brick")
                self.durability = 3
                self.canBreak = true
            case .Box:
                texture = SKTexture(imageNamed: "box")
                self.durability = 1
                self.canBreak = true
            case .River:
                texture = SKTexture(imageNamed: "river")
            case .Brush:
                texture = SKTexture(imageNamed: "brush")
            case .Empty:
                texture = SKTexture()
                break
        }
        super.init(texture: texture, color: UIColor.clear, size: self.mySize)
        
        self.name = "\(self.index)_\(self.myType)"
        
        if (self.myType != .Empty) {
            self.physicsBody = SKPhysicsBody(rectangleOf: self.mySize)
            self.physicsBody?.affectedByGravity = false
            self.physicsBody?.isDynamic = false
            self.zPosition = 1
        }
        
        if self.myType == .Empty {
            self.isHidden = true
        }
    }
    
    func getType()->objectType {
        return self.myType
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

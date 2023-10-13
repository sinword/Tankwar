//
//  AttackButton.swift
//  tankWar
//
//  Created by  陳奕軒 on 2023/4/23.
//

import UIKit
import SpriteKit

class JoystickButton: SKSpriteNode {
    let mySize = CGSize(width: 60, height: 60)
    var owner: Int
    var isReady = true
    
    init(name: String, owner: Int){
        let texture: SKTexture
        let newName: String
        if (name == "ability"){
            texture = SKTexture(imageNamed: "ability")
            newName = "\(owner) ability"
        }
        else{
            texture = SKTexture(imageNamed: "fire")
            newName = "\(owner) fire"
        }
        self.owner = owner
        super.init(texture: texture, color: UIColor.clear, size: mySize)
        self.name = newName
        self.zPosition = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

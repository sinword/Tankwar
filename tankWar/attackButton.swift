//
//  attackButton.swift
//  tankWar
//
//  Created by  陳奕軒 on 2023/4/23.
//

import UIKit
import SpriteKit

class attackButton: SKSpriteNode {
    let mySize = CGSize(width: 40, height: 40)
    var owner: Int
    
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

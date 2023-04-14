//
//  MapObject.swift
//  tankWar
//
//  Created by  陳奕軒 on 2023/4/14.
//

import UIKit
import SpriteKit

enum objectType : Int{
    case Wall = 0
    case Brick = 1
    case Box = 2
    case River = 3
    case Brush = 4
}

class MapObject: SKSpriteNode {
    var type = objectType.Wall
    var durability = 3
    var index = 0
    var canRebound = true
    var canBreak = true
  
}

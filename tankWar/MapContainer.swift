//
//  MapContainer.swift
//  tankWar
//
//  Created by  陳奕軒 on 2023/4/14.
//

import UIKit
import SpriteKit

class MapContainer: SKNode {
    let box = SKTexture(imageNamed: "box")
    let brick = SKTexture(imageNamed: "brick")
    let brush = SKTexture(imageNamed: "brush")
    let wall = SKTexture(imageNamed: "wall")
    let river = SKTexture(imageNamed: "river")
    let floor = SKTexture(imageNamed: "floor")
    var map = [[MapObject]]()
    
    func onInit(mapName: String){
        var content = ""
        if let path = Bundle.main.path(forResource: mapName, ofType: "txt",
                                       inDirectory: "maps"){
            do{
                content = try String(contentsOfFile: path, encoding: .utf8)
                print(content)
            }catch{
                print("Map file \(mapName) does not exist!")
                return
            }
        }
        content = content.replacingOccurrences(of: "\n", with: "")
        for i in 0..<11{
            var temp = [MapObject]()
            for j in 0..<11{
                let object: MapObject
                let str_idx = content.index(content.startIndex, offsetBy: i * 11 + j)
                switch(content[str_idx]){
                case "w":
                    object = MapObject(texture: brush)
                case "~":
                    object = MapObject(texture: river)
                case "=":
                    object = MapObject(texture: wall)
                case "#":
                    object = MapObject(texture: box)
                case "@":
                    object = MapObject(texture: brick)
                default:
                    object = MapObject()
                }
                //For position cal
                let width = 35
                object.size = CGSize(width: width, height: width)
                let x = j * width - (10 * width) / 2
                let y = i * width - (10 * width) / 2
                object.position = CGPoint(x: CGFloat(x), y: CGFloat(y))
                object.index = i * 11 + j
                object.zPosition = 0
                addChild(object)
                temp.append(object)
            }
            map.append(temp)
        }
    }

}


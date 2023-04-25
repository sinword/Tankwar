//
//  MapContainer.swift
//  tankWar
//
//  Created by  陳奕軒 on 2023/4/14.
//

import UIKit
import SpriteKit

class MapContainer: SKNode {
    var map = [[MapObject]]()
    
    func onInit(mapName: String) {
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
        for i in 0..<11 {
            var temp = [MapObject]()
            for j in 0..<11{
                let object: MapObject
                let idx = i * 11 + j
                let str_idx = content.index(content.startIndex, offsetBy: idx)
                switch(content[str_idx]){
                case "w":
                    object = MapObject(type: objectType.Brush ,index: idx)
                case "~":
                    object = MapObject(type: objectType.River ,index: idx)
                case "=":
                    object = MapObject(type: objectType.Wall ,index: idx)
                case "#":
                    object = MapObject(type: objectType.Box ,index: idx)
                case "@":
                    object = MapObject(type: objectType.Brick ,index: idx)
                default:
                    object = MapObject(type: objectType.Empty,index: idx)
                }
                
                //For position cal
                let width = Int(object.mySize.width)
                let x = j * width - (10 * width) / 2
                let y = i * width - (10 * width) / 2
                object.position = CGPoint(x: CGFloat(x), y: CGFloat(y))
                
                addChild(object)
                temp.append(object)
            }
            map.append(temp)
        }
    }

}


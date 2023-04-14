//
//  GameViewController.swift
//  tankWar
//
//  Created by  陳奕軒 on 2023/4/2.
//

import UIKit
import SpriteKit
import GameplayKit
import GameController

class GameViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            //let scene = menuScene(size: view.bounds.size)
            let scene = mainScene(size: view.bounds.size)
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            // Present the scene
            view.presentScene(scene)
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
        
        
    }
    
}

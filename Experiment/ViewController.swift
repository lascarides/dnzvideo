//
//  ViewController.swift
//  Experiment
//
//  Created by Michael NLNZ on 2/02/18.
//  Copyright © 2018 Digital New Zealand. All rights reserved.
//

import Cocoa
import SpriteKit
import GameplayKit

class ViewController: NSViewController {

    @IBOutlet var skView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let experimentScene = GameScene()
        experimentScene.scaleMode = .resizeFill
        
        // Present the scene
        if let view = self.skView {
            view.ignoresSiblingOrder = true
            view.showsFPS = false
            view.showsNodeCount = true
            view.presentScene(experimentScene)
            view.window?.toggleFullScreen(view)
        }
    }
}


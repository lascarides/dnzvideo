//
//  GameScene.swift
//  Experiment
//
//  Created by Michael NLNZ on 2/02/18.
//  Copyright © 2018 Digital New Zealand. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
        
    private var lastUpdateTime : TimeInterval = 0
    let vid = DNZPresentationVideo()
    let cam = Camera()

    override func sceneDidLoad() {
        self.backgroundColor = Colour.dark
        self.lastUpdateTime = 0
        addChild(vid)
        self.camera = cam
        self.addChild(cam)
    }
    
    func touchDown(atPoint pos : CGPoint) {
        vid.play()
//        sites.addActor(atPoint: pos)
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    override func mouseDown(with event: NSEvent) {
        self.touchDown(atPoint: event.location(in: self))
    }
    
    override func mouseDragged(with event: NSEvent) {
        self.touchMoved(toPoint: event.location(in: self))
    }
    
    override func mouseUp(with event: NSEvent) {
        self.touchUp(atPoint: event.location(in: self))
    }
    
//    override func keyDown(with event: NSEvent) {
//        switch event.keyCode {
//        case 0x31:
//            break
//            // Do things
//        default:
//            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
//        }
//    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        self.lastUpdateTime = currentTime
        
        vid.checkForAdvance()
                
    }
}

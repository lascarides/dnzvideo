//
//  Section.swift
//  DigitalNZ
//
//  Created by Michael NLNZ on 28/11/18.
//  Copyright © 2018 Digital New Zealand. All rights reserved.
//

import SpriteKit

class Section: SKNode, Advanceable {
    
    var completed = false
    var section = VideoSections.Intro
    var voiceover = SKAudioNode(url: URL(fileURLWithPath: "\(Settings.homePath)/voiceovers/01-intro.m4a"))
    var duration = 1.0
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func start() {
        let player = SKAction.run {
            self.addChild(self.voiceover)
        }
        let longWait = SKAction.wait(forDuration: duration)
        let ender = SKAction.run {
            self.completed = true
            self.voiceover.removeFromParent()
            self.removeFromParent()
        }
        let seq = SKAction.sequence([player, longWait, ender])
        run(seq)
    }
 
    func trigger(action: SKAction, delay: TimeInterval) {
        let timedWait = SKAction.wait(forDuration: delay)
        let seq = SKAction.sequence([timedWait, action])
        self.run(seq)
    }
    
}


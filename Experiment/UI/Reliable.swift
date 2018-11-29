//
//  Reliable.swift
//  DigitalNZ
//
//  Created by Michael NLNZ on 28/11/18.
//  Copyright © 2018 Digital New Zealand. All rights reserved.
//

import SpriteKit

class Reliable: Section {
    
    init(magicHat: MagicHat) {
        
        super.init()
        
        section     = VideoSections.Reliable
        voiceover   = SKAudioNode(url: URL(fileURLWithPath: "\(Settings.homePath)/voiceovers/06-reliable.m4a"))
        duration    = 13.653
        
        //        natlib.position = CGPoint(x: Screen.xPctCentered(pct: 0.5), y: Screen.yPctCentered(pct: 0.6))
        //        find.position   = CGPoint(x: Screen.xPctCentered(pct: 0.25), y: Screen.yPctCentered(pct: 0.25))
        //        share.position  = CGPoint(x: Screen.xPctCentered(pct: 0.5), y: Screen.yPctCentered(pct: 0.25))
        //        use.position    = CGPoint(x: Screen.xPctCentered(pct: 0.75), y: Screen.yPctCentered(pct: 0.25))
        //
        //        addChild(natlib)
        //        addChild(find)
        //        addChild(share)
        //        addChild(use)
        //
        //        trigger(action: SKAction.run { self.natlib.reveal() }, delay: 4.776)
        //        trigger(action: SKAction.run { self.find.reveal() }, delay: 8.829)
        //        trigger(action: SKAction.run { self.share.reveal() }, delay: 9.162)
        //        trigger(action: SKAction.run { self.use.reveal() }, delay: 9.809)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

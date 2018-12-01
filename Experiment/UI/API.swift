//
//  API.swift
//  DigitalNZ
//
//  Created by Michael NLNZ on 28/11/18.
//  Copyright © 2018 Digital New Zealand. All rights reserved.
//

import SpriteKit

class API: Section {
    
    let magicHat: MagicHat!
    
    init(magicHat: MagicHat) {
        
        self.magicHat = magicHat
        
        super.init()
        
        section     = VideoSections.API
        voiceover   = SKAudioNode(url: URL(fileURLWithPath: "\(Settings.homePath)/voiceovers/05-api.m4a"))
        duration    = 41.052

        //        trigger(action: SKAction.run { self.use.reveal() }, delay: 9.809)
        
        addChild(magicHat)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func resumeHat() {
        (self.scene! as! GameScene).cam.position = magicHat.logo.position
    }
    
}

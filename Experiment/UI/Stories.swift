//
//  Stories.swift
//  DigitalNZ
//
//  Created by Michael NLNZ on 28/11/18.
//  Copyright © 2018 Digital New Zealand. All rights reserved.
//

import SpriteKit

class Stories: Section {
    
    override init() {
        
        super.init()
        
        section     = VideoSections.Stories
        voiceover   = SKAudioNode(url: URL(fileURLWithPath: "\(Settings.homePath)/voiceovers/04-links-and-stories.m4a"))
        duration    = 26.535
        
        //        trigger(action: SKAction.run { self.use.reveal() }, delay: 9.809)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

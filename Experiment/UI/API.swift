//
//  API.swift
//  DigitalNZ
//
//  Created by Michael NLNZ on 28/11/18.
//  Copyright © 2018 Digital New Zealand. All rights reserved.
//

import SpriteKit

class API: Section {
    
    let magicHat = MagicHat(mode: .API)
    
    override init() {
        super.init()
        
        section     = VideoSections.API
        voiceover   = SKAudioNode(url: URL(fileURLWithPath: "\(Settings.homePath)/voiceovers/05-api.m4a"))
        duration    = 41.552

        trigger(action: SKAction.run { self.showAPI() }, delay: 11.253)
        trigger(action: SKAction.run { self.showResearch() }, delay: 15.0)
        trigger(action: SKAction.run { self.showLibrary() }, delay: 17.0)
        trigger(action: SKAction.run { self.showMobile() }, delay: 20.5)
        trigger(action: SKAction.run { self.showSupplejack() }, delay: 29.1)
        trigger(action: SKAction.run { self.showSupplejackCopy() }, delay: 35.5)
        trigger(action: SKAction.run { self.fadeout() }, delay: duration - 1)

        addChild(magicHat)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func resumeHat() {
        magicHat.shiftToAPI()
    }
    
    func showAPI() {
        magicHat.apiWidget.reveal()
        magicHat.logo.alpha = 0.5
    }
    
    func showResearch() {
        magicHat.apiResearch.reveal()
        magicHat.logo.emitItems(destination: magicHat.apiResearch.position)
    }
    
    func showLibrary() {
        magicHat.apiLibrary.reveal()
        magicHat.logo.emitItems(destination: magicHat.apiLibrary.position)
    }
    
    func showMobile() {
        magicHat.apiMobile.reveal()
        magicHat.logo.emitItems(destination: magicHat.apiMobile.position)
    }
    
    func showSupplejack() {
        magicHat.shiftToSupplejack()
    }
    
    func showSupplejackCopy() {
        magicHat.supplejack.showLabel()
    }
    
    func fadeout() {
        let fader = SKEase.fade(easeFunction: .curveTypeExpo, easeType: .easeTypeIn, time: 1.0, fromValue: 1.0, toValue: 0)
        self.run(fader)
    }
    
}

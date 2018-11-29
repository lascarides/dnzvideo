//
//  Intro.swift
//  DigitalNZ
//
//  Created by Michael NLNZ on 28/11/18.
//  Copyright © 2018 Digital New Zealand. All rights reserved.
//

import SpriteKit

class Intro: Section {
    
    let natlib      = Widget(type: .Natlib)
    let find        = Widget(type: .Find)
    let share       = Widget(type: .Share)
    let use         = Widget(type: .Use)
    let logo        = SKSpriteNode(texture: SKTexture(imageNamed: "\(Settings.homePath)/logo.png"))

    override init() {
        
        super.init()

        natlib.position = CGPoint(x: Screen.xPctCentered(pct: 0.7), y: Screen.yPctCentered(pct: 0.56))
        find.position   = CGPoint(x: Screen.xPctCentered(pct: 0.25), y: Screen.yPctCentered(pct: 0.25))
        share.position  = CGPoint(x: Screen.xPctCentered(pct: 0.5), y: Screen.yPctCentered(pct: 0.25))
        use.position    = CGPoint(x: Screen.xPctCentered(pct: 0.75), y: Screen.yPctCentered(pct: 0.25))

        logo.zPosition = 1000
        logo.setScale(0.7)
        
        natlib.setScale(1.3)

        addChild(logo)
        addChild(natlib)
        addChild(find)
        addChild(share)
        addChild(use)

        trigger(action: SKAction.run { self.logoMover() }, delay: 2.0)
        trigger(action: SKAction.run { self.natlib.reveal() }, delay: 4.776)
        trigger(action: SKAction.run { self.find.reveal() }, delay: 8.829)
        trigger(action: SKAction.run { self.share.reveal() }, delay: 9.162)
        trigger(action: SKAction.run { self.use.reveal() }, delay: 9.809)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func logoMover() {
        let newLogoPos = CGPoint(x: Screen.xPctCentered(pct: 0.3), y: Screen.yPctCentered(pct: 0.6))
        let mover = SKEase.move(easeFunction: .curveTypeExpo, easeType: .easeTypeInOut, time: 2.0, from: logo.position, to: newLogoPos)
        let scaler = SKEase.scale(easeFunction: .curveTypeExpo, easeType: .easeTypeInOut, time: 2.0, from: logo.xScale, to: 0.35)
        let grp = SKAction.group([mover, scaler])
        logo.run(grp)
    }

}

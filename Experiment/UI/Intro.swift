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
    let logoBox     = SKSpriteNode(color: Colour.red, size: CGSize(width: Screen.xPct(pct: 0.5) - 20, height: Screen.yPct(pct: 0.6) - 20))
    let natlibBox   = SKSpriteNode(color: Colour.sky, size: CGSize(width: Screen.xPct(pct: 0.5) - 20, height: Screen.yPct(pct: 0.6) - 20))
    let findBox     = SKSpriteNode(color: Colour.straw, size: CGSize(width: (Screen.width * 0.33) - 20, height: (Screen.height * 0.4) - 20))
    let shareBox     = SKSpriteNode(color: Colour.deepBlue, size: CGSize(width: (Screen.width * 0.33) - 20, height: (Screen.height * 0.4) - 20))
    let useBox     = SKSpriteNode(color: Colour.yello, size: CGSize(width: (Screen.width * 0.33) - 20, height: (Screen.height * 0.4) - 20))

    override init() {
        
        super.init()

        duration = 14.1
        
        natlib.position = CGPoint(x: Screen.xPctCentered(pct: 0.75), y: Screen.yPctCentered(pct: 0.7))
        find.position   = CGPoint(x: Screen.xPctCentered(pct: 0.1667), y: Screen.yPctCentered(pct: 0.2))
        share.position  = CGPoint(x: Screen.xPctCentered(pct: 0.5), y: Screen.yPctCentered(pct: 0.2))
        use.position    = CGPoint(x: Screen.xPctCentered(pct: 0.8333), y: Screen.yPctCentered(pct: 0.2))

        logo.position = CGPoint(x: Screen.xPctCentered(pct: 0.25), y: Screen.yPctCentered(pct: 0.7))
        logo.zPosition = 1000
        logo.setScale(0.35)
        
        natlib.setScale(1.6)

        find.setScale(1.4)
        share.setScale(1.4)
        use.setScale(1.4)

        logoBox.position    = logo.position
        natlibBox.position  = natlib.position
        findBox.position    = find.position
        shareBox.position   = share.position
        useBox.position     = use.position
        
        addChild(logoBox)
        addChild(natlibBox)
        addChild(findBox)
        addChild(shareBox)
        addChild(useBox)

        addChild(logo)
        addChild(natlib)
        addChild(find)
        addChild(share)
        addChild(use)

        trigger(action: SKAction.run { self.logoMover(); }, delay: 3.5)
        trigger(action: SKAction.run { self.natlib.reveal() }, delay: 7.0)
        trigger(action: SKAction.run { self.find.reveal() }, delay: 10.5)
        trigger(action: SKAction.run { self.share.reveal() }, delay: 11.5)
        trigger(action: SKAction.run { self.use.reveal() }, delay: 12.5)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cameraSetup() {
        (self.scene! as! GameScene).cam.position = logo.position
        (self.scene! as! GameScene).cam.setScale(0.5)
    }
    
    func logoMover() {
        (self.scene! as! GameScene).cam.modeSwitchWithTransition(scale: 1.0, centerPoint: CGPoint(x: 0, y: 0))
    }

}

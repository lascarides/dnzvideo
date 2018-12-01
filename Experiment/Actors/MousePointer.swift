//
//  MousePointer.swift
//  DigitalNZ
//
//  Created by Michael NLNZ on 2/12/18.
//  Copyright © 2018 Digital New Zealand. All rights reserved.
//

import SpriteKit

class MousePointer: SKNode {
    
    let mouse = SKSpriteNode(texture: SKTexture(imageNamed: "\(Settings.homePath)/icons/pointer.png"), size: CGSize(width: 60, height: 60))
    let clickCircle = SKShapeNode.init(circleOfRadius: 30)

    override init() {
        
        super.init()
        
        clickCircle.alpha = 0.0
        clickCircle.lineWidth = 0
        clickCircle.fillColor = Colour.red
        addChild(clickCircle)
        
        mouse.position = CGPoint(x: 27, y: -27)
        addChild(mouse)
        
        self.alpha = 0.0

    }

    func fadeIn() {
        let fader = SKEase.fade(easeFunction: .curveTypeExpo, easeType: .easeTypeInOut, time: 0.5, fromValue: 0.0, toValue: 1.0)
        self.run(fader)
    }
    
    func fadeOut() {
        let fader = SKEase.fade(easeFunction: .curveTypeExpo, easeType: .easeTypeInOut, time: 0.5, fromValue: 1.0, toValue: 0.0)
        self.run(fader)
    }
    
    func recenter() {
        self.position = CGPoint(x: 0, y: 0)
    }
    
    func move(to: CGPoint) {
        let mover = SKEase.move(easeFunction: .curveTypeExpo, easeType: .easeTypeInOut, time: 1.0, from: self.position, to: to)
        self.run(mover)
    }

    func click() {
        let blipIn = SKEase.scale(easeFunction: .curveTypeExpo, easeType: .easeTypeIn, time: 0.25, from: 1.0, to: 0.75)
        let blipOut = SKEase.scale(easeFunction: .curveTypeExpo, easeType: .easeTypeOut, time: 0.25, from: 0.75, to: 1.0)
        let blips = SKAction.sequence([blipIn, blipOut])
        mouse.run(blips)

        let wait = SKAction.wait(forDuration: 0.25)
        let fader = SKEase.fade(easeFunction: .curveTypeExpo, easeType: .easeTypeOut, time: 2.0, fromValue: 1.0, toValue: 0.0)
        let seq = SKAction.sequence([wait, fader])
        clickCircle.run(seq)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

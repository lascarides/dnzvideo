//
//  SupplejackLogo.swift
//  DigitalNZ
//
//  Created by Michael NLNZ on 30/11/18.
//  Copyright © 2018 Digital New Zealand. All rights reserved.
//

import SpriteKit


class SupplejackLogo: SKNode {
    
    let logo = SKSpriteNode(texture: SKTexture(imageNamed: "\(Settings.homePath)/supplejack.png"), size: CGSize(width: 350, height: 196))
    let label = TextBox(text: "Visit digitalnz.github.io/supplejack")

    override init() {
        super.init()
        addChild(logo)
        label.position = CGPoint(x: 0, y: -240)
        label.alpha = 0
        addChild(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showLabel() {
        let fader = SKEase.fade(easeFunction: .curveTypeExpo, easeType: .easeTypeInOut, time: 1.0, fromValue: 0, toValue: 1)
        label.run(fader)
    }
    
    func emitBits(destination: CGPoint) {
        let delay = 0.15
        let wait = SKAction.wait(forDuration: delay)
        let emitter = SKAction.run {
            var bit = SKShapeNode(circleOfRadius: 5)
            if Float.random(in: 0...1) > 0.5 {
                bit = SKShapeNode(rectOf: CGSize(width: 10, height: 2))
            }
            bit.position = self.position
            bit.zPosition = self.zPosition - 1
            bit.lineWidth = 0
            bit.fillColor = self.randomColour()
            self.parent!.addChild(bit)
            let follo = SKAction.move(to: destination, duration: 4.0)
            let bye = SKAction.run {
                bit.removeFromParent()
            }
            let seq = SKAction.sequence([follo, bye])
            bit.run(seq)
        }
        let seq = SKAction.sequence([wait, emitter])
        let rpt = SKAction.repeatForever(seq)
        self.run(rpt)
    }
    
    private func randomColour() -> NSColor {
        let colours = [
            Colour.deepBlue,
            Colour.gold,
            Colour.red,
            Colour.yello,
            Colour.sky,
            Colour.warmGray,
            ]
        return colours.randomElement()!
    }


}

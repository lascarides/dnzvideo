//
//  SupplejackLogo.swift
//  DigitalNZ
//
//  Created by Michael NLNZ on 30/11/18.
//  Copyright © 2018 Digital New Zealand. All rights reserved.
//

import SpriteKit


class SupplejackLogo: SKNode {
    
    let logo = ImageNode(name: "supplejack.png")
    
    override init() {
        super.init()
        logo.resize(to: CGSize(width: 200, height: 200))
        addChild(logo)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func emitBits(destination: CGPoint) {
        let delay = 0.3
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
                self.removeFromParent()
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

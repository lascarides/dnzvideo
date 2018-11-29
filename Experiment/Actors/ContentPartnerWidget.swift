//
//  ContentPartnerWidget.swift
//  DigitalNZ
//
//  Created by Michael NLNZ on 29/11/18.
//  Copyright © 2018 Digital New Zealand. All rights reserved.
//

import SpriteKit

class ContentPartnerWidget: SKNode {
    
    var label: TextBox!
    var matte: SKSpriteNode!
    var height  = CGFloat(20)
    var width   = CGFloat(100)
    var delay   = TimeInterval(Float.random(in: 0...3))
    
    init(partner: String) {

        let offset = CGFloat(10)
        let fontSize: CGFloat = 33
        label = TextBox(text: partner)
        label.fontSize = fontSize
        
        let matteH = fontSize + offset
        let matteW = label.frame.size.width + offset
        matte = SKSpriteNode(color: Colour.warmGray, size: CGSize(width: matteW, height: matteH))
        
        super.init()
        
        width = matteW + offset
        height = matteH + offset
        setRandomColour()
        
        addChild(matte)
        addChild(label)
        
        self.alpha = 0.0

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setRandomColour() {
        let colours = [
            Colour.deepBlue,
            Colour.gold,
            Colour.red,
            Colour.yello,
            Colour.sky
        ]
        switch colours.randomElement() {
        case Colour.deepBlue:
            matte.color = Colour.deepBlue
            label.fontColor = Colour.sky
        case Colour.gold:
            matte.color = Colour.gold
            label.fontColor = Colour.deepBlue
        case Colour.red:
            matte.color = Colour.red
            label.fontColor = Colour.straw
        case Colour.yello:
            matte.color = Colour.yello
            label.fontColor = Colour.dark
        default:
            matte.color = Colour.sky
            label.fontColor = Colour.white
        }
    }
    
    func reveal() {
        let wait = SKAction.wait(forDuration: delay)
        let revealer = SKAction.run {
            self.alpha = 1.0
        }
        let seq = SKAction.sequence([wait, revealer])
        run(seq)
    }
    
    func show() {
        self.alpha = 1.0
    }
    
    func fade() {
        let fader = SKEase.fade(easeFunction: .curveTypeExpo, easeType: .easeTypeInOut, time: 0.5, fromValue: 1.0, toValue: 0.4)
        run(fader)
    }
    
}

//
//  OpeningGallery.swift
//  DigitalNZ
//
//  Created by Michael NLNZ on 27/11/18.
//  Copyright © 2018 Digital New Zealand. All rights reserved.
//

import SpriteKit
import Foundation

class OpeningGallery: SKNode, Advanceable {
    
    var completed                   = false
    var section: VideoSections      = .OpeningGallery

    var images = [ImageNode]()
    var duration = Settings.musicBeat
    let text = TextBox(text: "Content Partner Name")

    let logo = SKSpriteNode(texture: SKTexture(imageNamed: "\(Settings.homePath)/logo.png"))

    override init() {
        super.init()
        for i in 0...23 {
            let node = ImageNode(name: "homegallery/\(i).jpg")
            images.append(node)
        }
        logo.alpha = 0.0
        logo.zPosition = 1000
        logo.setScale(0.7)
        logo.colorBlendFactor = 1.0
        addChild(logo)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func start() {
        addText()
        let show = SKAction.run {
            self.addChild(self.images[0])
            let scaler = SKEase.scale(easeFunction: .curveTypeLinear, easeType: .easeTypeIn, time: self.duration, from: 1.0, to: 1.1)
            self.images[0].zPosition = self.text.zPosition - 2
            self.images[0].run(scaler)
            self.logo.color = self.randomColour()
        }
        let wait = SKAction.wait(forDuration: self.duration * 0.25 * 0.25)
        let advance = SKAction.run {
            self.images[0].removeFromParent()
            self.cycleImages()
        }
        // 16 beat measures
        let tahi = SKAction.sequence([show, wait, wait, wait, wait, wait, wait, wait, wait, wait, wait, wait, wait, wait, wait, wait, wait, advance])
        // 8 beat measures
        let rua = SKAction.sequence([show, wait, wait, wait, wait, wait, wait, wait, wait,  advance])
        // 4 beat measures
        let toru = SKAction.sequence([show, wait, wait, advance])
        // 1 beat measures
        let wha = SKAction.sequence([show, wait, advance])
        let seq = SKAction.sequence([
            SKAction.repeat(tahi, count: 4),
            SKAction.repeat(rua, count: 6),
            SKAction.repeat(toru, count: 4),
            SKAction.repeat(wha, count: 8),
            SKAction.run {
                self.completed = true
                self.removeFromParent()
            }
            ])
        run(seq)
        
        // Slow fade on logo
        let logoWait = SKAction.wait(forDuration: Settings.musicBeat)
        let logoFader = SKAction.run {
            self.logo.alpha = 1.0
        }
        let logoSeq = SKAction.sequence([logoWait, logoWait, logoWait, logoWait, logoFader])
        logo.run(logoSeq)

    }
    
    private func cycleImages() {
        let lastImage = self.images.removeFirst()
        self.images.append(lastImage)
        
    }
    
    private func addText() {
        text.position = CGPoint(x: Screen.xPctCentered(pct: 0.5), y: Screen.yPctCentered(pct: 0.08))
        text.zPosition = 101
//        addChild(text)
    }

    private func randomColour() -> NSColor {
        let colours = [
            Colour.deepBlue,
            Colour.gold,
            Colour.red,
            Colour.yello,
            Colour.sky
        ]
        return colours.randomElement()!
    }
    

}

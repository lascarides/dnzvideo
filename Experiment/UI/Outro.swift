//
//  Outro.swift
//  DigitalNZ
//
//  Created by Michael NLNZ on 28/11/18.
//  Copyright © 2018 Digital New Zealand. All rights reserved.
//

import SpriteKit

class Outro: Section {

    let logo = SKSpriteNode(texture: SKTexture(imageNamed: "\(Settings.homePath)/logo.png"))
    let matte = SKSpriteNode(color: Colour.red, size: Screen.cgSize())
    let birthday = TextBox(text: "Celebrating 10 years")
    let birthdayYears = TextBox(text: "2008–2018")

    override init() {
        
        super.init()
        
        section     = VideoSections.Outro
        voiceover   = SKAudioNode(url: URL(fileURLWithPath: "\(Settings.homePath)/voiceovers/06-outro.m4a"))
        duration    = 17.171

        matte.zPosition = 1000
        addChild(matte)

        logo.setScale(0.7)
        logo.zPosition = 1001
        addChild(logo)

        birthday.position = CGPoint(x: 0, y: Screen.yPctCentered(pct: 0.8))
        birthdayYears.position = CGPoint(x: 0, y: Screen.yPctCentered(pct: 0.2))
        birthday.zPosition = 1001
        birthdayYears.zPosition = 1001
        addChild(birthdayYears)
        addChild(birthday)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

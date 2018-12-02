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
    let birthday = TextBox(text: "CELEBRATING 10 YEARS — 2008–2018")
    let urlLabel = TextBox(text: "digitalnz.org")

    var gallery = [String: ImageNode]()
    
    override init() {
        
        super.init()
        
        section     = VideoSections.Outro
        voiceover   = SKAudioNode(url: URL(fileURLWithPath: "\(Settings.homePath)/voiceovers/06-outro.m4a"))
        duration    = 23.518
        self.alpha  = 0

        logo.setScale(0.5)
        logo.position = CGPoint(x: 0, y: Screen.yPctCentered(pct: 0.65))
        logo.zPosition = 2
        logo.alpha = 0.0
        addChild(logo)

        urlLabel.position = CGPoint(x: 0, y: Screen.yPctCentered(pct: 0.35))
        urlLabel.zPosition = 3
        urlLabel.fontSize = urlLabel.fontSize * 2.5
        urlLabel.alpha = 0.0
        addChild(urlLabel)

        birthday.position = CGPoint(x: 0, y: Screen.yPctCentered(pct: 0.2))
        birthday.zPosition = 4
        birthday.alpha = 0.0
        addChild(birthday)
        
        let width = (Screen.width * 0.33)
        let height = (Screen.height * 0.5)
        for cat in ["culture", "history", "affairs", "research", "science", "data"] {
            let img = ImageNode(name: "endgallery/\(cat).jpg")
            img.resize(to: Screen.cgSize())
            img.zPosition = 1000
            addChild(img)
            gallery[cat] = img
        }

        trigger(action: SKAction.run { self.fadeIn() }, delay: 0.1)

        trigger(action: SKAction.run { self.displayImage(name: "culture") }, delay: 0.1)
        trigger(action: SKAction.run { self.displayImage(name: "history") }, delay: 5.157)
        trigger(action: SKAction.run { self.displayImage(name: "affairs") }, delay: 6.036)
        trigger(action: SKAction.run { self.displayImage(name: "research") }, delay: 7.335)
        trigger(action: SKAction.run { self.displayImage(name: "science") }, delay: 8.414)
        trigger(action: SKAction.run { self.displayImage(name: "data") }, delay: 9.2)

        trigger(action: SKAction.run { self.fadeOut() }, delay: 12.0)

        trigger(action: SKAction.run { self.finalHurrah() }, delay: duration - 5)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    func displayImage(name: String) {
        for img in gallery {
            img.value.alpha = 0
        }
        gallery[name]!.alpha = 1.0
        let scaler = SKEase.scale(easeFunction: .curveTypeLinear, easeType: .easeTypeIn, time: 5.0, from: 1.0, to: 1.1)
        gallery[name]!.run(scaler)
    }
    
    func fadeIn() {
        let fadeIn = SKEase.fade(easeFunction: .curveTypeExpo, easeType: .easeTypeInOut, time: 2.0, fromValue: 0.0, toValue: 1.0)
        self.run(fadeIn)
    }

    func fadeOut() {
        for img in gallery {
            img.value.alpha = 0
        }
        let fadeIn = SKEase.fade(easeFunction: .curveTypeExpo, easeType: .easeTypeInOut, time: 2.0, fromValue: 0.0, toValue: 1.0)
        logo.run(fadeIn)
        urlLabel.run(fadeIn)
        birthday.run(fadeIn)
        (parent! as! DNZPresentationVideo).raiseBackgroundMusicVolume()
    }
    
    func finalHurrah() {
        urlLabel.text = "Credits & citations coming soon!"
        let fadeOut = SKEase.fade(easeFunction: .curveTypeExpo, easeType: .easeTypeInOut, time: 5.0, fromValue: 1.0, toValue: 0.0)
        self.run(fadeOut)
        (parent! as! DNZPresentationVideo).slowFadeBackgroundMusicVolume()
    }
    
}

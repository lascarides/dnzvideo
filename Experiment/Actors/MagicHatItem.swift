//
//  MagicHatItem.swift
//  DigitalNZ
//
//  Created by Michael NLNZ on 29/11/18.
//  Copyright © 2018 Digital New Zealand. All rights reserved.
//

import SpriteKit

class MagicHatItem: SKNode {
    
    var matte: SKSpriteNode!
    var imageNode: ImageNode?

    override init() {
        
        matte = SKSpriteNode(color: Colour.white, size: CGSize(width: 50, height: 50))
        
        super.init()
        
        matte.color = randomColour()
        
        self.addChild(matte)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    func addImageNode(name: String) {
        let w = Screen.width / 16.0
        let h = Screen.height / 9.0
        imageNode = ImageNode(name: name)
        imageNode!.resize(to: CGSize(width: w * 3, height: h * 3))
        imageNode!.zPosition = 200
        imageNode!.alpha = 0
        addChild(imageNode!)
    }
    
    func revealImageNode() {
        let fadein = SKEase.fade(easeFunction: .curveTypeExpo, easeType: .easeTypeOut, time: 0.75, fromValue: 0.0, toValue: 1)
        imageNode!.run(fadein)
    }
    
}

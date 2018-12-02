//
//  Holdings.swift
//  DigitalNZ
//
//  Created by Michael NLNZ on 28/11/18.
//  Copyright © 2018 Digital New Zealand. All rights reserved.
//

import SpriteKit

class Holdings: Section {

    var littleSquares = [LittleSquare]()
    
    var contentTypes = [String: LittleSquare]()
    
    override init() {
        
        super.init()
        
        section     = VideoSections.Holdings
        voiceover   = SKAudioNode(url: URL(fileURLWithPath: "\(Settings.homePath)/voiceovers/02-holdings.m4a"))
        duration    = 12.639 + 23.0
        
        trigger(action: SKAction.run { self.revealVideo() }, delay: 12.639)

        for x in 1...16 {
            for y in 1...9 {
                let sq = LittleSquare(x: x, y: y)
                sq.zPosition = 100
                littleSquares.append(sq)
            }
        }

        addContentFeature(index: 24, name: "books")
        addContentFeature(index: 128, name: "news")
        addContentFeature(index: 59, name: "archives")
        addContentFeature(index: 94, name: "video")
        addContentFeature(index: 124, name: "audio")
        addContentFeature(index: 29, name: "images")

        for sq in littleSquares {
            addChild(sq)
            sq.reveal()
        }

        trigger(action: SKAction.run { self.contentTypes["books"]!.revealImageNode() }, delay: 3.837)
        trigger(action: SKAction.run { self.contentTypes["news"]!.revealImageNode() }, delay: 8.631)
        trigger(action: SKAction.run { self.contentTypes["archives"]!.revealImageNode() }, delay: 7.865)
        trigger(action: SKAction.run { self.contentTypes["video"]!.playVideo() }, delay: 7.021)
        trigger(action: SKAction.run { self.contentTypes["audio"]!.revealImageNode() }, delay: 5.548)
        trigger(action: SKAction.run { self.contentTypes["images"]!.revealImageNode() }, delay: 4.585)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func revealVideo() {
        voiceover.removeFromParent()
        let v = VideoPlayer(name: "bryony", duration: 22.190)
        v.zPosition = 99
        addChild(v)
        v.start()
        for sq in littleSquares {
            sq.disappear()
        }
    }
    
    private func addContentFeature(index: Int, name: String) {
        contentTypes[name] = littleSquares[index]
        contentTypes[name]!.addImageNode(name: "holdings/\(name).jpg")
    }

    
}

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
        voiceover   = SKAudioNode(url: URL(fileURLWithPath: "\(Settings.homePath)/voiceovers/03-holdings.m4a"))
        duration    = 11.076
        
        trigger(action: SKAction.run { self.revealVideo() }, delay: duration - 2)

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

        trigger(action: SKAction.run { self.contentTypes["books"]!.revealImageNode() }, delay: 3.397)
        trigger(action: SKAction.run { self.contentTypes["news"]!.revealImageNode() }, delay: 7.551)
        trigger(action: SKAction.run { self.contentTypes["archives"]!.revealImageNode() }, delay: 6.547)
        trigger(action: SKAction.run { self.contentTypes["video"]!.playVideo() }, delay: 5.597)
        trigger(action: SKAction.run { self.contentTypes["audio"]!.revealImageNode() }, delay: 4.556)
        trigger(action: SKAction.run { self.contentTypes["images"]!.revealImageNode() }, delay: 3.917)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func revealVideo() {
        let v = VideoPlayer(name: "bryony")
        v.zPosition = 99
        addChild(v)
        for sq in littleSquares {
            sq.disappear()
        }
    }
    
    private func addContentFeature(index: Int, name: String) {
        contentTypes[name] = littleSquares[index]
        contentTypes[name]!.addImageNode(name: "holdings/\(name).jpg")
        if name == "video" {
            contentTypes[name]!.addVideo()
        }
    }

    
}

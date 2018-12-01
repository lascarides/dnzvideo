//
//  Camera.swift
//  DigitalNZ
//
//  Created by Michael NLNZ on 29/11/18.
//  Copyright © 2018 Digital New Zealand. All rights reserved.
//

import SpriteKit

class Camera: SKCameraNode {
    
    let mouse = MousePointer()
    
    override init() {
        super.init()
        addChild(mouse)

        // MOUSE TESTS
//        let wait = SKAction.wait(forDuration: 1.0)
//        let fadeIn = SKAction.run{ self.mouse.fadeIn() }
//        let fadeOut = SKAction.run{ self.mouse.fadeOut() }
//        let move = SKAction.run{ self.mouse.move(to: CGPoint(x: 100, y: 100)) }
//        let recenter = SKAction.run{ self.mouse.recenter() }
//        let click = SKAction.run{ self.mouse.click() }
//        let seq = SKAction.sequence([fadeIn, wait, move, wait, click, wait, recenter, wait, click, wait, fadeOut])
//        mouse.run(seq)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func modeSwitchWithTransition(scale: CGFloat, centerPoint: CGPoint) {
        let scaleAction = SKEase.scale(easeFunction: .curveTypeExpo, easeType: .easeTypeInOut, time: 2.0, from: self.xScale, to: scale)
        let moveAction = SKEase.move(easeFunction: .curveTypeExpo, easeType: .easeTypeInOut, time: 2.0, from: self.position, to: centerPoint)
        let actions = SKAction.group([scaleAction, moveAction])
        self.run(actions)
    }
    
    func recenter() {
        self.position = CGPoint(x: 0, y: 0)
        self.setScale(1.0)
    }
    
}

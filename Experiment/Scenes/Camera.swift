//
//  Camera.swift
//  DigitalNZ
//
//  Created by Michael NLNZ on 29/11/18.
//  Copyright © 2018 Digital New Zealand. All rights reserved.
//

import SpriteKit

class Camera: SKCameraNode {
    
    override init() {
        super.init()
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
    }
    
}

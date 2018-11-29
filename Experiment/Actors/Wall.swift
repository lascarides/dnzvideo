//
//  Wall.swift
//  Experiment
//
//  Created by Michael NLNZ on 9/03/18.
//  Copyright © 2018 Digital New Zealand. All rights reserved.
//

import SpriteKit

class Wall: SKNode {
    
    var sprite          = SKSpriteNode(color: NSColor.red, size: CGSize(width: 20, height: 20))
    
    init( size: CGSize, position: CGPoint) {
        super.init()
        sprite.size = size
        sprite.alpha = 0.1
        self.position = position
        attachPhysics()
        addChild(sprite)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func attachPhysics() {
        let p = SKPhysicsBody(rectangleOf: sprite.size)
        p.affectedByGravity = false
        p.isDynamic = false
        p.mass = 1
        p.categoryBitMask = UInt32(1)
        p.collisionBitMask = UInt32(2)
        self.physicsBody = p
    }
    
}


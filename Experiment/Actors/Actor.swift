//
//  Actor.swift
//  Experiment
//
//  Created by Michael NLNZ on 23/02/18.
//  Copyright © 2018 Digital New Zealand. All rights reserved.
//

import SpriteKit
import GameplayKit

enum ActorExpressions {
    case Walking
    case Asking
    case Browsing
    case Happy
    case Sad
}

enum ActorSkinTones {
    case Pale
    case LessPale
    case Olive
    case Tan
    case Yellowy
    case Brown
    case Dark
}

class Actor: SKNode {
    
    var sprite          = SKShapeNode(circleOfRadius: 1)
    var speechBubble    = SKLabelNode(text: "test")
    var expression      = ActorExpressions.Walking
    var skin            = ActorSkinTones.Tan
    
    init(size: CGSize) {
        super.init()
        position = CGPoint(x:0, y: 200)
        sprite = SKShapeNode(circleOfRadius: size.width * 0.5)
        sprite.glowWidth = 0.0
        sprite.alpha = 0.5
        attachPhysics(radius: size.width * 0.5)
        addChild(sprite)
        addChild(speechBubble)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func attachPhysics(radius: CGFloat) {
        let padding = CGFloat(1.0)
        let p = SKPhysicsBody(circleOfRadius: radius + padding)
//        let p = SKPhysicsBody(rectangleOf: CGSize(width: sprite.size.width + padding, height: sprite.size.height + padding))
        p.affectedByGravity = true
        p.allowsRotation = false
        p.friction = 0.001
        p.isDynamic = true
        p.mass = 1
        p.applyForce(CGVector(dx: 0.5, dy: 20.0))
        p.categoryBitMask = UInt32(2)
        p.collisionBitMask = UInt32(3)
        self.physicsBody = p
        if radius < 20 {
            speechBubble.alpha = 0.0
        }
    }
    
    func setLabel(_ newText: String) {
        speechBubble.text = newText
        speechBubble.fontSize = 10.0
        speechBubble.fontName = "ArcherPro"
    }
    
    func resize(_ newSize: CGSize) {
        sprite = SKShapeNode(circleOfRadius: newSize.width * 0.5)
        sprite.glowWidth = 0.0
    }
    
}

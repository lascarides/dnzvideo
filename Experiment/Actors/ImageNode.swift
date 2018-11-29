//
//  ImageNode.swift
//  DigitalNZ
//
//  Created by Michael NLNZ on 26/11/18.
//  Copyright © 2018 Digital New Zealand. All rights reserved.
//

import SpriteKit

class ImageNode: SKCropNode {
    
    var node: SKSpriteNode!
    
    init(name: String) {
        super.init()
        
        let url = URL(fileURLWithPath: "\(Settings.homePath)/\(name)")
        let img = NSImage(byReferencing: url)
        let texture = SKTexture(image: img)
        node = SKSpriteNode(texture: texture, color: NSColor.clear, size: texture.size())
        self.resize(to: Screen.cgSize())
        self.addChild(node)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func scaleImageInside(to: CGFloat) {
        node.setScale(to)
    }
    
    func resize(to: CGSize) {
        self.maskNode = SKSpriteNode(color: NSColor.black, size: to)
        let imageAspectRatio = node.size.width / node.size.height
        let maskAspectRatio = to.width / to.height
        if imageAspectRatio > maskAspectRatio {
            let newHeight = to.height
            let newWidth = newHeight * imageAspectRatio
            node.size = CGSize(width: newWidth, height: newHeight)
        } else {
            let newWidth = to.width
            let newHeight = newWidth / imageAspectRatio
            node.size = CGSize(width: newWidth, height: newHeight)
        }
    }
    
}






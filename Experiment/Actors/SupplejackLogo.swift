//
//  SupplejackLogo.swift
//  DigitalNZ
//
//  Created by Michael NLNZ on 30/11/18.
//  Copyright © 2018 Digital New Zealand. All rights reserved.
//

import SpriteKit


class SupplejackLogo: SKNode {
    
    let logo = ImageNode(name: "supplejack.png")
    
    override init() {
        super.init()
        logo.resize(to: CGSize(width: 200, height: 200))
        addChild(logo)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

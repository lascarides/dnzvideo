//
//  TextBox.swift
//  DigitalNZ
//
//  Created by Michael NLNZ on 29/11/18.
//  Copyright © 2018 Digital New Zealand. All rights reserved.
//

import SpriteKit

class TextBox: SKLabelNode {
    
    init(text: String) {
        super.init()
        self.text = text
        self.fontName = "ArcherPro"
        self.fontSize = 40
        self.fontColor = Colour.white
        self.verticalAlignmentMode = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

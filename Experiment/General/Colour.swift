//
//  Colour.swift
//  DigitalNZ
//
//  Created by Michael NLNZ on 28/11/18.
//  Copyright © 2018 Digital New Zealand. All rights reserved.
//

import AppKit

extension NSColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}


class Colour {
    
    static let dark         = NSColor(rgb: 0x111111)
    static let white        = NSColor(rgb: 0xFFFFFF)
    static let cream        = NSColor(rgb: 0xEAD2AE)
    static let warmGray     = NSColor(rgb: 0xC4B9A7)
    static let deepBlue     = NSColor(rgb: 0x146793)
    static let sky          = NSColor(rgb: 0x5C9BAC)
    static let red          = NSColor(rgb: 0xD91B1D)
    static let gold         = NSColor(rgb: 0xD69B23)
    static let yello        = NSColor(rgb: 0xDCB617)
    static let straw        = NSColor(rgb: 0xF0E9D9)
    static let clear        = NSColor.clear

}

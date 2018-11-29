//
//  ScreenSize.swift
//  DigitalNZ
//
//  Created by Michael NLNZ on 13/03/18.
//  Copyright © 2018 Digital New Zealand. All rights reserved.
//

import SpriteKit

class Screen {
    
    static let size     = NSScreen.main!.visibleFrame
    static let height   = NSScreen.main!.visibleFrame.height + 22
    static let width    = NSScreen.main!.visibleFrame.width
    
    class func xPct(pct: CGFloat) -> CGFloat {
        return width * pct
    }
    
    class func yPct(pct: CGFloat) -> CGFloat {
        return height * pct
    }
    
    class func xPctCentered(pct: CGFloat) -> CGFloat {
        return width * (pct - CGFloat(0.5))
    }
    
    class func yPctCentered(pct: CGFloat) -> CGFloat {
        return height * (pct - CGFloat(0.5))
    }
 
    class func cgSize() -> CGSize {
        return CGSize(width: width, height: height)
    }
    
    class func aspectRatio() -> CGFloat {
        return width / height
    }
    
}

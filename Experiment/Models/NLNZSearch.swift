//
//  NLNZSearch.swift
//  DigitalNZ
//
//  Created by Michael NLNZ on 13/03/18.
//  Copyright © 2018 Digital New Zealand. All rights reserved.
//

import Foundation
import SpriteKit

class NLNZSearch: SKNode {
    
    var query           = "default query"
    var startDate       = NSDate()
    var endDate         = NSDate()
    var usage           = "All"
    var collection      = "All"
    var organisation    = "All"
    var format          = "All"
    var count           = 0

    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


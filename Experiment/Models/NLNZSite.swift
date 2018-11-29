//
//  NLNZSite.swift
//  Experiment
//
//  Created by Michael NLNZ on 16/02/18.
//  Copyright © 2018 Digital New Zealand. All rights reserved.
//

import SpriteKit

class NLNZSite: SKNode {
    
    var title           = "Default Name"
    var pageviews       = 0
    var sessions        = 0
    var visitors        = 0
    var uniqueSearches  = 0
    
    var collections     = [NLNZCollection]()
    var mostPopularItems    = [NLNZItem]()
    var randomItems         = [NLNZItem]()

}

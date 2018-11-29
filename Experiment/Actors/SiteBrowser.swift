//
//  SiteBrowser.swift
//  Experiment
//
//  Created by Michael NLNZ on 16/02/18.
//  Copyright © 2018 Digital New Zealand. All rights reserved.
//

import SpriteKit

class SiteBrowser: SKNode {
    let base        = Wall(size: CGSize(width: Screen.width, height: 10), position: CGPoint(x: Screen.width * 0.5, y: 0))
    let leftwall    = Wall(size: CGSize(width: 10, height: Screen.height), position: CGPoint(x: 0, y: 0))
    let rightwall   = Wall(size: CGSize(width: 10, height: Screen.height), position: CGPoint(x: Screen.width, y: 0))
    let dnz         = DigitalNZ()
    var ignoreNLNZ  = true


    override init() {
//        natlib.name     = "National Library Web Site"
//        natlib.sessions = 2116204
//        natlib.pageviews = 8077619
//        natlib.visitors = 1432738
//
//        digitalnz.name  = "DigitalNZ"
//        digitalnz.sessions = 179949
//        digitalnz.pageviews = 925460
//        digitalnz.visitors = 117843
//
//        paperspast.name = "Papers Past"
//        paperspast.sessions = 1948936
//        paperspast.pageviews = 37983929 // FIXME needs adjusted for error
//        paperspast.visitors = 1093864

        super.init()
        
        addChild(base)
        addChild(leftwall)
        addChild(rightwall)

        makeDots()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeOrgs() {
        var xoffset = 600
        var yoffset = 1000
        for org in dnz.allOrganisations() {
            if !(ignoreNLNZ && org.title == "National Library of New Zealand+") {
                let newActor = Actor(size: getSize(count: org.itemCount))
                newActor.position = CGPoint(x: xoffset, y: yoffset)
                xoffset += 1
                if xoffset > 800 {
                    xoffset = 500
                    yoffset += 1
                }
                newActor.setLabel(org.title)
                switch org.category {
                case "Museum":
                    newActor.sprite.fillColor = NSColor.cyan
                case "Library":
                    newActor.sprite.fillColor = NSColor.red
                case "Archives":
                    newActor.sprite.fillColor = NSColor.yellow
                case "Community":
                    newActor.sprite.fillColor = NSColor.purple
                case "Government":
                    newActor.sprite.fillColor = NSColor.orange
                case "University":
                    newActor.sprite.fillColor = NSColor.gray
                case "Media":
                    newActor.sprite.fillColor = NSColor.green
                case "Non-profit":
                    newActor.sprite.fillColor = NSColor.magenta
                case "Gallery":
                    newActor.sprite.fillColor = NSColor.brown
                case "Aggregator":
                    newActor.sprite.fillColor = NSColor.systemPink
                default:
                    break
                }
                newActor.sprite.strokeColor = NSColor.clear
                addChild(newActor)
            }
        }
    }
    
    func makeDots() {
        var xoffset = 600
        var yoffset = 1000
        for org in dnz.allOrganisations() {
            if !(ignoreNLNZ && org.title == "National Library of New Zealand+") {
                var itemcount = org.itemCount
                while itemcount > 0 {
                    let newActor = Actor(size: CGSize(width: 19, height:19))
                    newActor.position = CGPoint(x: xoffset, y: yoffset)
                    xoffset += 1
                    if xoffset > 800 {
                        xoffset = 500
                        yoffset += 1
                    }
                    newActor.setLabel(org.title)
                    switch org.category {
                    case "Museum":
                        newActor.sprite.fillColor = NSColor.cyan
                    case "Library":
                        newActor.sprite.fillColor = NSColor.red
                    case "Archives":
                        newActor.sprite.fillColor = NSColor.yellow
                    case "Community":
                        newActor.sprite.fillColor = NSColor.purple
                    case "Government":
                        newActor.sprite.fillColor = NSColor.orange
                    case "University":
                        newActor.sprite.fillColor = NSColor.gray
                    case "Media":
                        newActor.sprite.fillColor = NSColor.green
                    case "Non-profit":
                        newActor.sprite.fillColor = NSColor.magenta
                    case "Gallery":
                        newActor.sprite.fillColor = NSColor.brown
                    case "Aggregator":
                        newActor.sprite.fillColor = NSColor.systemPink
                    default:
                        break
                    }
                    newActor.sprite.strokeColor = NSColor.clear
                    addChild(newActor)
                    itemcount -= 10000
                }
            }
        }
    }
    

    func getSize(count: Int) -> CGSize {
        let maxSize = 350.0
        var counter = Double(count).squareRoot() / Double(maxItems()).squareRoot()
        var sides = counter * maxSize
//        let countLog = log2(Double(count).squareRoot())
//        var sides = countLog * 10.0
        if sides < 10 {
            sides = 10
        }
        return CGSize(width: CGFloat(sides), height: CGFloat(sides))
    }
    
    func maxItems() -> Int {
        var maxItem = 0
        for org in dnz.allOrganisations() {
            if !(ignoreNLNZ && org.title == "National Library of New Zealand+") {
                if org.itemCount > maxItem {
                    maxItem = org.itemCount
                }
            }
        }
        return maxItem
    }
    
}


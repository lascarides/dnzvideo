//
//  Stories.swift
//  DigitalNZ
//
//  Created by Michael NLNZ on 28/11/18.
//  Copyright © 2018 Digital New Zealand. All rights reserved.
//

import SpriteKit

class Stories: Section {
    
    var screenshot = ImageNode(name: "screenshots/stories-01.jpg")
    
    override init() {
        
        super.init()
        
        section     = VideoSections.Stories
        voiceover   = SKAudioNode(url: URL(fileURLWithPath: "\(Settings.homePath)/voiceovers/04-links-and-stories.m4a"))
        duration    = 27.065
        
        trigger(action: SKAction.run { self.setUpMouse() }, delay: 0.001)
        trigger(action: SKAction.run { self.clickOnSource() }, delay: 3.0)
        trigger(action: SKAction.run { self.addToStories() }, delay: 14.6)

        addChild(screenshot)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpMouse() {
        let mouse = (self.scene! as! GameScene).cam.mouse
        let wait = SKAction.wait(forDuration: 1.0)
        let fade = SKAction.run {
            mouse.fadeIn()
        }
        let seq = SKAction.sequence([wait,fade])
        mouse.move(to: CGPoint(x: Screen.xPctCentered(pct: 0.2), y: Screen.yPctCentered(pct: 0.2)))
        run(seq)
    }
    
    private func clickOnSource() {
        
        let mouse = (self.scene! as! GameScene).cam.mouse
        let sourceX = Screen.xPctCentered(pct: (1266.0 / 1920.0))
        let sourceY = Screen.xPctCentered(pct: (510.0 / 1080.0))
        let newPoint = CGPoint(x: sourceX, y: sourceY)
        
        let wait = SKAction.wait(forDuration: 1.0)
        
        let move = SKAction.run{
            mouse.move(to: newPoint)
        }
        let click = SKAction.run{
            mouse.click()
        }
        let replace = SKAction.run{
            mouse.fadeOut()
            self.screenshot.changeTexture(name: "screenshots/stories-02.jpg")
            self.screenshot.node.position.y = (self.screenshot.node.size.height * -0.5) + (Screen.height * 0.5)
        }
        let scroller = SKAction.run{
            let scroll = SKEase.move(easeFunction: .curveTypeExpo, easeType: .easeTypeInOut, time: 4.0, from: self.screenshot.node.position, to: CGPoint(x: 0, y: 0))
            self.screenshot.node.run(scroll)
        }
        //        let seq = SKAction.sequence([move, wait, zoom, wait, click, wait, replace, wait, wait, scroller])
        let seq = SKAction.sequence([move, wait, wait, click, wait, replace, wait, wait, scroller])
        mouse.run(seq)
    }
    
    private func addToStories() {
        
        let mouse = (self.scene! as! GameScene).cam.mouse
        let sourceX = Screen.xPctCentered(pct: (1152.0 / 1920.0))
        let sourceY = Screen.xPctCentered(pct: (650.0 / 1080.0))
        let newPoint = CGPoint(x: sourceX, y: sourceY)
        
        let setup = SKAction.run{
            mouse.fadeIn()
            self.screenshot.changeTexture(name: "screenshots/stories-01.jpg")
            self.screenshot.node.position = CGPoint(x: 0, y: 0)
        }

        let wait = SKAction.wait(forDuration: 1.0)
        
        let move = SKAction.run{
            mouse.move(to: newPoint)
        }
        let click = SKAction.run{
            mouse.click()
        }
        let replace = SKAction.run{
            mouse.fadeOut()
            self.screenshot.changeTexture(name: "screenshots/stories-03.jpg")
            self.screenshot.node.position.y = (self.screenshot.node.size.height * -0.5) + (Screen.height * 0.5)
        }
        let replace2 = SKAction.run{
            self.screenshot.changeTexture(name: "screenshots/stories-04.jpg")
            self.screenshot.node.position.y = (self.screenshot.node.size.height * -0.5) + (Screen.height * 0.5)
        }
        let scroller = SKAction.run{
            let scroll = SKEase.move(easeFunction: .curveTypeExpo, easeType: .easeTypeInOut, time: 4.0, from: self.screenshot.node.position, to: CGPoint(x: 0, y: 0))
            self.screenshot.node.run(scroll)
        }
        let seq = SKAction.sequence([setup, move, wait, wait, click, wait, replace, wait, wait, replace2, wait, wait, scroller])
        mouse.run(seq)
    }
    
}

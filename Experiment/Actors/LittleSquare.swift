//
//  LittleSquare.swift
//  DigitalNZ
//
//  Created by Michael NLNZ on 29/11/18.
//  Copyright © 2018 Digital New Zealand. All rights reserved.
//

import SpriteKit

class LittleSquare: SKNode {
    
    var x: CGFloat = 0
    var y: CGFloat = 0
    var node: SKSpriteNode!
    var matte: SKSpriteNode!
    var imageNode: ImageNode?
    var videoNode: VideoPlayer?
    var delay = TimeInterval(Float.random(in: 0 ..< 1))

    let gridW = Screen.width / 17.0
    let gridH = Screen.height / 10.0

    var xOffset: CGFloat {
        get {
            return Screen.xPctCentered(pct: x * (1/17))
        }
    }
    
    var yOffset: CGFloat {
        get {
            return Screen.yPctCentered(pct: y * (1/10))
        }
    }
    
    init(x: Int, y: Int) {

        matte = SKSpriteNode(color: Colour.dark, size: CGSize(width: self.gridW, height: self.gridH))

        let gutter: CGFloat = 8
        node = SKSpriteNode(color: Colour.dark, size: CGSize(width: self.gridW - gutter, height: self.gridH - gutter))

        super.init()

        node.color = randomColour()
        
        self.addChild(matte)
        self.addChild(node)
        
        let icon = loadIcon()
        icon.scale(to: CGSize(width: node.size.width * 0.6, height: node.size.width * 0.6))
        icon.alpha = 0.4
        addChild(icon)

        self.x = CGFloat(x)
        self.y = CGFloat(y)
        self.position = CGPoint(x: self.xOffset, y: self.yOffset)
        self.alpha = 0.0
        self.zPosition = 100 + CGFloat(delay)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func randomColour() -> NSColor {
        let colours = [
            Colour.deepBlue,
            Colour.gold,
            Colour.red,
            Colour.yello,
            Colour.sky,
            Colour.straw,
            Colour.straw,
            Colour.warmGray,
        ]
        return colours.randomElement()!
    }
    
    func reveal() {
        matte.alpha = 0
        let wait = SKAction.wait(forDuration: TimeInterval(delay))
        let fadein = SKEase.fade(easeFunction: .curveTypeExpo, easeType: .easeTypeOut, time: 1.0, fromValue: 0.1, toValue: 1)
        let scaler = SKEase.scale(easeFunction: .curveTypeExpo, easeType: .easeTypeOut, time: 1.0, from: 0.1, to: 1)
        let grp = SKAction.group([fadein, scaler])
        self.run( SKAction.sequence([wait, grp]))
    }
    
    func disappear() {
        let wait = SKAction.wait(forDuration: TimeInterval(delay))
        let hide = SKEase.fade(easeFunction: .curveTypeExpo, easeType: .easeTypeOut, time: 1.0, fromValue: 1.0, toValue: 0)
        self.run( SKAction.sequence([wait, hide]))
    }
    
    func addImageNode(name: String) {
        imageNode = ImageNode(name: name)
        imageNode!.resize(to: CGSize(width: gridW * 3, height: gridH * 3))
        imageNode!.zPosition = 200
        imageNode!.alpha = 0
        addChild(imageNode!)
    }
    
    func revealImageNode() {
        let fadein = SKEase.fade(easeFunction: .curveTypeExpo, easeType: .easeTypeOut, time: 0.75, fromValue: 0.0, toValue: 1)
        imageNode!.run(fadein)
    }
    
    func addVideo() {
        let cropNode = SKCropNode()
        cropNode.maskNode = SKSpriteNode(color: Colour.deepBlue, size: CGSize(width: gridW * 3, height: gridH * 3))
        videoNode = VideoPlayer(name: "tractorparade", duration: 1000)
        imageNode!.resize(to: CGSize(width: gridW * 3, height: gridH * 3))
        videoNode!.resize(to: imageNode!.maskNode!.frame.size)
        videoNode!.alpha = 0
        cropNode.zPosition = 201
        cropNode.addChild(videoNode!)
        addChild(cropNode)
    }
    
    func playVideo() {
        addVideo()
        let fadein = SKEase.fade(easeFunction: .curveTypeExpo, easeType: .easeTypeOut, time: 0.75, fromValue: 0.0, toValue: 1)
        videoNode?.run(fadein)
        videoNode?.start()
    }
    
    private func loadIcon() -> SKSpriteNode {
        let icons = [
            "archive.png",
            "find.png",
            "gallery.png",
            "govt.png",
            "book.png",
            "library.png",
            "media.png",
            "museum.png",
            "share.png",
            "use.png"
        ]
        let iconName = icons.randomElement()
        let url = URL(fileURLWithPath: "\(Settings.homePath)/icons/\(iconName!)")
        let img = NSImage(byReferencing: url)
        let texture = SKTexture(image: img)
        let node = SKSpriteNode(texture: texture, color: NSColor.clear, size: texture.size())
        return node
    }

    
}

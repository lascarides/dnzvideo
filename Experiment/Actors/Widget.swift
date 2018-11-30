//
//  Widget.swift
//  DigitalNZ
//
//  Created by Michael NLNZ on 28/11/18.
//  Copyright © 2018 Digital New Zealand. All rights reserved.
//

import SpriteKit

enum WidgetTypes {
    case Find
    case Share
    case Use
    case Natlib
    case Museum
    case Library
    case Archive
    case Gallery
    case Media
    case Govt
    case MagicHat
}

class Widget: SKNode {
    
    let matte = SKShapeNode(circleOfRadius: 100)
    var icon = SKSpriteNode(color: Colour.white, size: CGSize(width: 40, height: 40))
    let label = TextBox(text: "Find")
    var type: WidgetTypes!
    
    init(type: WidgetTypes) {
        self.type = type
        super.init()
        
        matte.fillColor = Colour.red
        matte.strokeColor = Colour.clear
        addChild(matte)
        
        label.position = CGPoint(x: 0, y: -40)
        addChild(label)
        
        self.alpha = 0.0
     
        switch type {
        case .Find:
            icon = loadIcon(name: "find.png")
            matte.fillColor = Colour.red
            label.text = "Find"
            icon.scale(to: CGSize(width: 60, height: 60))
        case .Share:
            icon = loadIcon(name: "share.png")
            matte.fillColor = Colour.yello
            label.text = "Share"
            icon.scale(to: CGSize(width: 60, height: 60))
        case .Use:
            icon = loadIcon(name: "use.png")
            matte.fillColor = Colour.sky
            label.text = "Use"
            icon.scale(to: CGSize(width: 60, height: 60))
        case .Museum:
            icon = loadIcon(name: "museum.png")
            matte.fillColor = Colour.sky
            label.text = "Museums"
            icon.scale(to: CGSize(width: 60, height: 60))
        case .Archive:
            icon = loadIcon(name: "archive.png")
            matte.fillColor = Colour.deepBlue
            label.text = "Archives"
            icon.scale(to: CGSize(width: 60, height: 60))
        case .Gallery:
            icon = loadIcon(name: "gallery.png")
            matte.fillColor = Colour.yello
            label.text = "Galleries"
            icon.scale(to: CGSize(width: 60, height: 60))
        case .Library:
            icon = loadIcon(name: "library.png")
            matte.fillColor = Colour.red
            label.text = "Libraries"
            icon.scale(to: CGSize(width: 60, height: 60))
        case .Media:
            icon = loadIcon(name: "media.png")
            matte.fillColor = Colour.gold
            label.text = "Media"
            icon.scale(to: CGSize(width: 60, height: 60))
        case .Govt:
            icon = loadIcon(name: "govt.png")
            matte.fillColor = Colour.warmGray
            label.text = "Govt"
            icon.scale(to: CGSize(width: 60, height: 60))
        case .Natlib:
            icon = loadIcon(name: "natlib.png")
            matte.fillColor = Colour.clear
            label.removeFromParent()
            icon.setScale(0.5)
        case .MagicHat:
            matte.fillColor = Colour.dark
            icon = SKSpriteNode(texture: SKTexture(imageNamed: "\(Settings.homePath)/logo-only.png"))
            icon.size = matte.frame.size
            label.removeFromParent()
        }
        
        if type != .MagicHat && type != .Natlib {
            icon.position = CGPoint(x: 0, y: 30)
        }

        addChild(icon)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reveal() {
        let fadein = SKEase.fade(easeFunction: .curveTypeExpo, easeType: .easeTypeOut, time: 1.0, fromValue: 0.5, toValue: 1)
        let scaler = SKEase.scale(easeFunction: .curveTypeBack, easeType: .easeTypeOut, time: 1.0, from: 0.2, to: 1)
        let grp = SKAction.group([fadein, scaler])
        self.run(grp)
    }
    
    func smol() {
        matte.setScale(0.20)
        label.alpha = 0.0
        icon.size = CGSize(width: 20, height: 20)
        icon.alpha = 0.7
        icon.position = CGPoint(x: 0, y: 0)
    }
    
    func takeALittleTrip(destination: CGPoint) {
        let follo = SKAction.move(to: destination, duration: 4.0)
        let bye = SKAction.run {
            self.removeFromParent()
        }
        let seq = SKAction.sequence([follo, bye])
        self.run(seq)
    }
    
    func emitItems(destination: CGPoint) {
        let delay = (self.type == .MagicHat) ? 0.4 : 0.4
        let wait = SKAction.wait(forDuration: delay)
        let emitter = SKAction.run {
            var emittedType = self.type
            if self.type == .MagicHat {
                emittedType = [
                    WidgetTypes.Museum,
                    WidgetTypes.Library,
                    WidgetTypes.Archive,
                    WidgetTypes.Gallery,
                    WidgetTypes.Media,
                    WidgetTypes.Govt
                ].randomElement()
            }
            let emitted = Widget(type: emittedType!)
            emitted.smol()
            emitted.reveal()
            emitted.position = self.position
            emitted.zPosition = self.zPosition - 1
            self.parent!.addChild(emitted)
            emitted.takeALittleTrip(destination: destination)
        }
        let seq = SKAction.sequence([wait, emitter])
        let rpt = SKAction.repeatForever(seq)
        self.run(rpt)
    }
    
    private func loadIcon(name: String) -> SKSpriteNode {
        let url = URL(fileURLWithPath: "\(Settings.homePath)/icons/\(name)")
        let img = NSImage(byReferencing: url)
        let texture = SKTexture(image: img)
        let node = SKSpriteNode(texture: texture, color: NSColor.clear, size: texture.size())
        return node
    }

}

//
//  VideoPlayer.swift
//  DigitalNZ
//
//  Created by Michael NLNZ on 27/11/18.
//  Copyright © 2018 Digital New Zealand. All rights reserved.
//

import AVFoundation
import SpriteKit

class VideoPlayer: SKVideoNode, Advanceable {

    var player: AVPlayer
    var completed                   = false
    var section: VideoSections      = .TinaVideo

    let nameLabel = TextBox(text: "TINA MAKERETI")
    let descriptiveLabel = TextBox(text: "Author")
    
    let waitForCatchup: TimeInterval = 0.5
    
    var soundtrack: SKAudioNode?

    init(name: String, duration: Double) {
        let vidURL = URL(fileURLWithPath: "\(Settings.homePath)/video/\(name).mov")
        let video = AVPlayerItem(url: vidURL)
        player = AVPlayer(playerItem: video)
        player.volume = 0
        super.init(avPlayer: player)
//        NotificationCenter.default.addObserver(self, selector: #selector(self.playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: video)
        
        // Ensure initial size of node is set to video dimensions
        let track = AVURLAsset(url: vidURL).tracks(withMediaType: AVMediaType.video).first
        let newSize = track!.naturalSize.applying(track!.preferredTransform)
        size = CGSize(width: newSize.width, height: newSize.height)

        // Resize to screen size by default
        resize(to: Screen.cgSize())
        
        // Use labels, if necessary
        setUpLabels(name: name)
        
        // Add soundtrack, if necessary
        if (name == "tina" || name == "olivia" || name == "bryony") {
            soundtrack = SKAudioNode(url: URL(fileURLWithPath: "\(Settings.homePath)/voiceovers/\(name).m4a"))
            let fader = SKEase.fade(easeFunction: .curveTypeExpo, easeType: .easeTypeIn, time: 1.0, fromValue: 1.0, toValue: 0)
            trigger(action: fader, delay: duration + waitForCatchup - 1)
            trigger(action: SKAction.run { self.finished() }, delay: duration + waitForCatchup)
        } else {
            // Set timings
            trigger(action: SKAction.run { self.finished() }, delay: duration)
        }

        // Add Tina extras
        if name == "tina" {
            trigger(action: SKAction.run { self.tinaExtras() }, delay: 19.5 + waitForCatchup)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func start() {
        let wait = SKAction.wait(forDuration: waitForCatchup)
        let starter = SKAction.run {
            self.player.play()
            if self.soundtrack != nil {
                self.addChild(self.soundtrack!)
            }
        }
        let seq = SKAction.sequence([wait, starter])
        run(seq)
    }
    
//    @objc private func playerDidFinishPlaying(note: NSNotification) {
    func finished() {
        soundtrack?.removeFromParent()
        soundtrack = nil
        removeFromParent()
        completed = true
    }
 
    func resize(to newSize: CGSize) {
        let imageAspectRatio = size.width / size.height
        let newAspectRatio = newSize.width / newSize.height
        if imageAspectRatio > newAspectRatio {
            let newHeight = newSize.height
            let newWidth = newHeight * imageAspectRatio
            size = CGSize(width: newWidth, height: newHeight)
        } else {
            let newWidth = newSize.width
            let newHeight = newWidth / imageAspectRatio
            size = CGSize(width: newWidth, height: newHeight)
        }
    }
    
    func trigger(action: SKAction, delay: TimeInterval) {
        let timedWait = SKAction.wait(forDuration: delay)
        let seq = SKAction.sequence([timedWait, action])
        self.run(seq)
    }

    private func tinaExtras() {
        let rekohu = SKSpriteNode(texture: SKTexture(imageNamed: "\(Settings.homePath)/rekohu.jpg"), size: Screen.cgSize())
        rekohu.alpha = 0.0
        addChild(rekohu)
        
        let scaly = SKEase.scale(easeFunction: .curveTypeLinear, easeType: .easeTypeInOut, time: 7.0, from: rekohu.xScale, to: rekohu.xScale * 1.1)
        rekohu.run(scaly)

        let waiter = SKAction.wait(forDuration: 4.0)
        let fadeIn = SKEase.fade(easeFunction: .curveTypeExpo, easeType: .easeTypeInOut, time: 2.0, fromValue: 0, toValue: 1)
        let fadeOut = SKEase.fade(easeFunction: .curveTypeExpo, easeType: .easeTypeInOut, time: 2.0, fromValue: 1, toValue: 0)
        let removal = SKAction.run {
            rekohu.removeFromParent()
        }
        let seq = SKAction.sequence([fadeIn,waiter,fadeOut,removal])
        rekohu.run(seq)
    }
    
    private func setUpLabels(name: String) {
        if (name != "tina" && name != "olivia" && name != "bryony") {
            return
        }
        nameLabel.alpha = 0.0
        descriptiveLabel.alpha = 0.0
        nameLabel.horizontalAlignmentMode = .left
        descriptiveLabel.horizontalAlignmentMode = .left
        nameLabel.fontColor = Colour.dark
        descriptiveLabel.fontColor = Colour.dark
        descriptiveLabel.fontSize = 36
        nameLabel.position = CGPoint(x: Screen.xPctCentered(pct: 0.05), y: Screen.yPctCentered(pct: 0.9))
        descriptiveLabel.position = nameLabel.position
        descriptiveLabel.position.y -= 40
        if (name == "olivia") {
            nameLabel.text = "OLIVIA NIKKEL"
            descriptiveLabel.text = "Publisher"
        }
        if (name == "bryony") {
            nameLabel.text = "BRYONY WOOD"
            descriptiveLabel.text = "Teacher"
        }
        addChild(nameLabel)
        addChild(descriptiveLabel)
        
        let waiter = SKAction.wait(forDuration: 3.0)
        let fader = SKEase.fade(easeFunction: .curveTypeQuadratic, easeType: .easeTypeInOut, time: 1.0, fromValue: 0, toValue: 1)
        let seq = SKAction.sequence([waiter, fader])
        nameLabel.run(seq)
        descriptiveLabel.run(seq)

    }

}



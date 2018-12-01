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
            trigger(action: fader, delay: duration - 1)
        }

        // Set timings
        trigger(action: SKAction.run { self.finished() }, delay: duration)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func start() {
        player.play()
        if soundtrack != nil {
            addChild(soundtrack!)
        }
    }
    
//    @objc private func playerDidFinishPlaying(note: NSNotification) {
    func finished() {
        print("done")
        completed = true
        soundtrack?.removeFromParent()
        soundtrack = nil
        removeFromParent()
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



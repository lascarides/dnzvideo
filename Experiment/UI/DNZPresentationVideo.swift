//
//  DNZPresentationVideo.swift
//  DigitalNZ
//
//  Created by Michael NLNZ on 26/11/18.
//  Copyright © 2018 Digital New Zealand. All rights reserved.
//

import SpriteKit

enum VideoSections {
    case OpeningGallery
    case Intro
    case Holdings
    case ContentPartners
    case Stories
    case API
    case TinaVideo
    case OliviaVideo
    case Outro
}

protocol Advanceable {
    var section: VideoSections { get set }
    var completed: Bool { get set }
    func start() -> Void
}

class DNZPresentationVideo: SKNode {
    
    let sections = [
        VideoSections.OpeningGallery,
        VideoSections.Intro,
        VideoSections.Holdings,
        VideoSections.ContentPartners,
        VideoSections.TinaVideo,
        VideoSections.Stories,
        VideoSections.OliviaVideo,
        VideoSections.API,
        VideoSections.Outro
    ]
    
    let backgroundMusic = SKAudioNode(url: URL(fileURLWithPath: "\(Settings.homePath)/bg.m4a"))
    var bgMusicLoud = true
    var currentSection: Advanceable! = OpeningGallery()
    
    var status: VideoSections = .OpeningGallery {
        didSet {
            changeStatus(status)
        }
    }

    override init() {
        super.init()
        addChild( currentSection as! SKNode )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func play() {

        addChild(backgroundMusic)
        
        // Get music clip on beat
        let wait = SKAction.wait(forDuration: Settings.musicStartDelay)
        let runner = SKAction.run {
            NSCursor.setHiddenUntilMouseMoves(true)
            self.currentSection.start()
        }
        let seq = SKAction.sequence([wait, runner])
        run(seq)

        // Slow fade-in on self
        let allFader = SKEase.fade(easeFunction: .curveTypeLinear, easeType: .easeTypeIn, time: Settings.musicBeat, fromValue: 0.0, toValue: 1.0)
        run(allFader)

    }
    
    func lowerBackgroundMusicVolume() {
        if (bgMusicLoud) {
            backgroundMusic.run(SKAction.changeVolume(to: 0.05, duration: 1.5))
            bgMusicLoud = false
        }
    }
    
    func raiseBackgroundMusicVolume() {
        if (bgMusicLoud == false) {
            backgroundMusic.run(SKAction.changeVolume(to: 1.0, duration: 3.0))
            bgMusicLoud = true
        }
    }
    
    func slowFadeBackgroundMusicVolume() {
        if (bgMusicLoud) {
            backgroundMusic.run(SKAction.changeVolume(to: 0, duration: 5.0))
            bgMusicLoud = false
        }
    }
    
    func checkForAdvance() {
        if (currentSection.completed && status == currentSection.section) {
            if currentSection.section == .Outro {
                endVideo()
                return
            }
            var i = 0
            for section in sections {
                i += 1
                if currentSection.section == section {
                    status = sections[i]
                    break
                }
            }
        }
    }
    
    private func endVideo() {
        // Cleanup happens here
    }
    
    private func changeStatus(_ status: VideoSections) {
        (currentSection as! SKNode).removeFromParent()
        (self.scene! as! GameScene).cam.recenter()
        switch status {
        case .OpeningGallery:
            break
        case .Intro:
            let intro = Intro()
            sectionPlay(intro)
            intro.cameraSetup()
        case .Holdings:
            sectionPlay(Holdings())
        case .ContentPartners:
            sectionPlay(MagicHat())
        case .Stories:
            sectionPlay(Stories())
        case .API:
            let api = API()
            sectionPlay(api)
            api.resumeHat()
        case .Outro:
            sectionPlay(Outro())
        case .TinaVideo:
            let v = VideoPlayer(name: "tina", duration: 32.916)
            addChild(v)
            currentSection = v
            v.start()
        case .OliviaVideo:
            let v = VideoPlayer(name: "olivia", duration: 11.170)
            v.section = .OliviaVideo
            addChild(v)
            (self.scene! as! GameScene).cam.recenter()
            currentSection = v
            v.start()
        default:
            break
        }
    }
    
    private func sectionPlay(_ section: Section) {
        lowerBackgroundMusicVolume()
        addChild(section)
        currentSection = section
        section.start()
    }
    
}

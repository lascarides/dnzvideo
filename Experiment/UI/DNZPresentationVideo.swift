//
//  DNZPresentationVideo.swift
//  DigitalNZ
//
//  Created by Michael NLNZ on 26/11/18.
//  Copyright © 2018 Digital New Zealand. All rights reserved.
//

import SpriteKit

enum VideoSections {
    case Waiting
    case OpeningGallery
    case Intro
    case Holdings
    case BryonyVideo
    case ContentPartners
    case DigitalNZOrg
    case Reliable
    case Stories
    case Supplejack
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
        VideoSections.DigitalNZOrg,
        VideoSections.TinaVideo,
        VideoSections.Reliable,
        VideoSections.Stories,
        VideoSections.OliviaVideo,
        VideoSections.API,
        VideoSections.Supplejack,
        VideoSections.Outro
    ]
    
    let backgroundMusic = SKAudioNode(url: URL(fileURLWithPath: "\(Settings.homePath)/bg.m4a"))
    var bgMusicLoud = true
    var currentSection: Advanceable! = OpeningGallery()

    let magicHat = MagicHat()
    
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
            backgroundMusic.run(SKAction.changeVolume(to: 1.0, duration: 1.0))
            bgMusicLoud = true
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
            sectionPlay(magicHat)
        case .DigitalNZOrg:
            sectionPlay(DigitalNZOrg())
        case .Reliable:
            sectionPlay(Reliable(magicHat: magicHat))
        case .Stories:
            sectionPlay(Stories())
        case .API:
            let api = API(magicHat: magicHat)
            sectionPlay(api)
            api.resumeHat()
        case .Supplejack:
            sectionPlay(Supplejack(magicHat: magicHat))
        case .Outro:
            sectionPlay(Outro())
        case .BryonyVideo:
            let v = VideoPlayer(name: "bryony")
            v.section = .BryonyVideo
            addChild(v)
            currentSection = v
            v.start()
        case .TinaVideo:
            let v = VideoPlayer(name: "tina")
            addChild(v)
            (self.scene! as! GameScene).cam.recenter()
            currentSection = v
            v.start()
        case .OliviaVideo:
            let v = VideoPlayer(name: "olivia")
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

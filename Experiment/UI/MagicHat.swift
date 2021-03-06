//
//  ContentPartners.swift
//  DigitalNZ
//
//  Created by Michael NLNZ on 28/11/18.
//  Copyright © 2018 Digital New Zealand. All rights reserved.
//

import SpriteKit

enum MagicHatModes {
    case MagicHat
    case API
}

class MagicHat: Section {
    
    var contentPartners = [ContentPartnerWidget]()
    let logo = Widget(type: .MagicHat)
    let supplejack = SupplejackLogo()
    let dnzVideo = VideoPlayer(name: "screencast-0-home-whina", duration: 1000.0)
    var widgets = [Widget]()
    let apiWidget       = Widget(type: .API)
    let apiLibrary      = Widget(type: .APILibrary)
    let apiResearch     = Widget(type: .APIResearch)
    let apiMobile       = Widget(type: .APIMobile)

    init(mode: MagicHatModes = .MagicHat) {
        
        super.init()
        
        section     = VideoSections.ContentPartners
        voiceover   = SKAudioNode(url: URL(fileURLWithPath: "\(Settings.homePath)/voiceovers/03-magic-hat-1.m4a"))
        duration    = 37.99
        
        for partner in contentPartnerList() {
            let widget = ContentPartnerWidget(partner: partner)
            contentPartners.append(widget)
        }

        var offsetX: CGFloat = 0.7
        var offsetY: CGFloat = 0.2
        for category in [WidgetTypes.Media, WidgetTypes.Govt, WidgetTypes.Gallery, WidgetTypes.Library, WidgetTypes.Archive, WidgetTypes.Museum] {
            let widget = Widget(type: category)
            let pX = Screen.xPctCentered(pct: offsetX)
            let pY = Screen.yPctCentered(pct: offsetY)
            widget.position = CGPoint(x: pX, y: pY)
            widget.zPosition = 1000
            if offsetX == 0.7 {
                offsetX = 0.9
            } else {
                offsetY += 0.3
                offsetX = 0.7
            }
            addChild(widget)
            widgets.append(widget)
        }
        
        
        if mode == .MagicHat {
            // COntent partners wall
            let partnersCrop = SKCropNode()
            partnersCrop.maskNode = SKSpriteNode(color: Colour.dark, size: Screen.cgSize())
            addChild(partnersCrop)
            
            var xOffset = Screen.xPctCentered(pct: -0.1)
            var yOffset = Screen.yPctCentered(pct: -0.1)
            
            while (xOffset < Screen.xPctCentered(pct: 1.1) && yOffset < Screen.yPctCentered(pct: 1.1))  {
                
                let partner = contentPartners.randomElement()!
                
                if partner.parent == nil {
                    let xPos = xOffset + (partner.width * 0.5)
                    partner.position = CGPoint(x: xPos, y: yOffset)
                    partnersCrop.addChild(partner)
                    
                    // Advance as needed, or exit loop
                    xOffset += partner.width
                    if xOffset > Screen.xPctCentered(pct: 1.1) {
                        xOffset = Screen.xPctCentered(pct: -0.1)
                        yOffset += partner.height
                    }
                    
                    partner.reveal()
                }
                
            }
        }
        
        logo.position = CGPoint(x: Screen.xPctCentered(pct: 1.25), y: Screen.yPctCentered(pct: 0.5))
        logo.zPosition = 1000
        addChild(logo)
        
        dnzVideo.position = CGPoint(x: Screen.xPctCentered(pct: 1.5), y: 0)
        dnzVideo.zPosition = 1000
        dnzVideo.alpha = 0
        dnzVideo.resize(to: CGSize(width: 200, height: 200 / Screen.aspectRatio() ))
        addChild(dnzVideo)
        
        if mode == .MagicHat {
            trigger(action: SKAction.run{ self.shiftToHarvest() }, delay: 9.935)
            trigger(action: SKAction.run{ self.shiftToMagicHat() }, delay: 14.088)
            trigger(action: SKAction.run{ self.shiftToWebsite() }, delay: 20.452)
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func shiftToHarvest() {
        logo.reveal()
        var dest = logo.position
        for partner in contentPartners {
            partner.fade()
        }
        for widget in widgets {
            widget.reveal()
            dest.x += 10
            widget.emitItems(destination: dest)
        }
        let newPoint = CGPoint(x: Screen.xPctCentered(pct: 1.0), y: 0)
        (self.scene! as! GameScene).cam.modeSwitchWithTransition(scale: 1.0, centerPoint: newPoint)
    }

    func shiftToMagicHat() {
        logo.emitItems(destination: dnzVideo.position)
        let fader = SKEase.fade(easeFunction: .curveTypeExpo, easeType: .easeTypeInOut, time: 1.0, fromValue: 0, toValue: 1)
        dnzVideo.run(fader)
        (self.scene! as! GameScene).cam.modeSwitchWithTransition(scale: 1.0, centerPoint: logo.position)
    }
    
    func shiftToWebsite() {
        let scale = CGFloat(200) / Screen.width
        (self.scene! as! GameScene).cam.modeSwitchWithTransition(scale: scale, centerPoint: dnzVideo.position)
        dnzVideo.start()
    }
    
    func shiftToAPI() {
        var dest = logo.position
        for partner in contentPartners {
            partner.fade()
        }
        for widget in widgets {
            widget.position.x += 200
            if widget.type == WidgetTypes.Archive || widget.type == WidgetTypes.Media || widget.type == WidgetTypes.Gallery  {
                widget.position.x += 100

            }
            widget.reveal()
            dest.x += 10
            widget.emitItems(destination: dest)
        }
        logo.reveal()
        shiftToMagicHat()
        apiMobile.position = dnzVideo.position
        apiMobile.position.x -= 100
        apiMobile.position.y -= 200
        apiMobile.zPosition = logo.zPosition + 1
        addChild(apiMobile)
        
        apiLibrary.position = dnzVideo.position
        apiLibrary.position.x -= 100
        apiLibrary.position.y += 300
        apiLibrary.zPosition = logo.zPosition + 1
        addChild(apiLibrary)

        apiResearch.position = dnzVideo.position
        apiResearch.position.x += 250
        apiResearch.position.y += 200
        apiResearch.zPosition = logo.zPosition + 1
        addChild(apiResearch)
        
        apiWidget.position = logo.position
        apiWidget.zPosition = logo.zPosition + 1
        addChild(apiWidget)
    }

    func shiftToSupplejack() {
        supplejack.position = logo.position
        supplejack.position.y -= 300
        supplejack.zPosition = logo.zPosition
        let fader = SKEase.fade(easeFunction: .curveTypeExpo, easeType: .easeTypeIn, time: 1.0, fromValue: 0, toValue: 1)
        addChild(supplejack)
        supplejack.run(fader)
        (self.scene! as! GameScene).cam.modeSwitchWithTransition(scale: 0.8, centerPoint: supplejack.position)
        supplejack.emitBits(destination: logo.position)
    }
    
    private func contentPartnerList() -> [String] {
        let partners = [
            "95bFM",
            "Accident Compensation Corporation",
            "AgEcon Search",
            "Alexander Turnbull Library",
            "Amuri Historical Society",
            "Antarctica New Zealand",
            "Aotearoa People's Network Kaharoa",
            "Archives Central",
            "Archives New Zealand Te Rua Mahara o te Kāwanatanga",
            "AttitudeLive",
            "Auckland Art Gallery Toi o Tāmaki",
            "Auckland Council",
            "Auckland Council Archives",
            "Auckland Libraries",
            "Auckland University of Technology",
            "Auckland War Memorial Museum Tamaki Paenga Hira",
            "Audio Foundation",
            "AudioCulture",
            "Australian National Maritime Museum",
            "Beacon Pathway Ltd",
            "BRANZ",
            "British Pathé",
            "Bronwyn Holloway-Smith",
            "Buller, Grey and Westland District Libraries",
            "Canterbury 100",
            "Canterbury Museum",
            "Carterton District Library",
            "Central Otago Memory Bank",
            "Centre for Housing Research Aotearoa New Zealand",
            "Christchurch City Libraries",
            "Christchurch Polytechnic Institute of Technology, Te Wānanga Ōtautahi",
            "Christchurch uncovered",
            "CORE Education",
            "data.govt.nz",
            "Department of Building and Housing",
            "Department of Conservation Te Papa Atawhai",
            "Department of Corrections",
            "Department of Internal Affairs",
            "Department of Labour",
            "Deutsche Digitale Bibliothek",
            "Digital Public Library of America",
            "DigitalNZ",
            "Directory of Open Access Journals",
            "Down to the Wire",
            "Dunedin City Council Archives",
            "Dunedin Public Art Gallery",
            "E-Tangata",
            "Eastern Institute of Technology",
            "Energy Efficiency and Conservation Authority",
            "eqnz.chch.2010",
            "Europeana",
            "Feilding Library",
            "FigShare",
            "Forest and Bird",
            "Free Music Archive",
            "Freesound",
            "Gisborne Photo News",
            "Gus Fisher Gallery",
            "Hamilton City Libraries",
            "HathiTrust",
            "Howick Historical Village",
            "Hurunui District Libraries",
            "Hutt City Council",
            "Hutt City Libraries",
            "Institute of Environmental Science and Research Ltd (ESR)",
            "Internet Archive",
            "Isel House",
            "Kawerau District Library",
            "Kent Palmer Art",
            "Kete Central Hawke's Bay",
            "Kete Christchurch",
            "Kete Hauraki Coromandel",
            "Kete Horowhenua",
            "Kete King Country",
            "Kete Masterton",
            "Kete New Plymouth",
            "Kete Rotorua",
            "Kete Selwyn",
            "Kete Tararua",
            "Kete Tasman",
            "Kete Taupo",
            "Kowai Archives",
            "Landcare Trust",
            "Laurie Family",
            "LERNZdb",
            "Lincoln University",
            "Lost Christchurch",
            "Manaaki Whenua – Landcare Research",
            "Massey University",
            "Mataura Museum",
            "Ministry for Culture and Heritage",
            "Ministry for the Environment",
            "Ministry of Fisheries Te Tautiaki i nga tini a Tangaroa",
            "Ministry of Health",
            "Ministry of Tourism Te Manatū Tāpoi",
            "Mix & Mash 2011",
            "Motu Economic and Public Policy Research",
            "MTG Hawke's Bay",
            "Museum of New Zealand Te Papa Tongarewa",
            "Museum Victoria",
            "mychillybin",
            "National Library of Australia",
            "National Library of New Zealand",
            "NatureWatch NZ",
            "Nelson Photo News",
            "Nelson Provincial Museum",
            "New Zealand Book Council",
            "New Zealand Cricket Museum",
            "New Zealand Electronic Text Collection",
            "New Zealand Fashion Museum",
            "New Zealand Film Commission",
            "New Zealand Journal of Forestry Science",
            "New Zealand Medical Association",
            "New Zealand Plant Conservation Network",
            "New Zealand Police",
            "New Zealand Taxation",
            "New Zealand Tertiary College",
            "Nga Manu Nature Reserve",
            "Ngā Taonga Sound & Vision",
            "NIWA",
            "North Otago Museum",
            "NZ Musician",
            "NZ On Screen",
            "NZEI Te Riu Roa (New Zealand Educational Institute)",
            "Open Polytechnic",
            "Palmerston North Libraries and Community Services",
            "Paul Spain",
            "Picture Australia",
            "Plant & Food Research",
            "Play It Strange",
            "Powerhouse Museum",
            "Productivity Commission",
            "PSA Journal",
            "Public Address",
            "Puke Ariki",
            "Radio New Zealand",
            "Raglan and District Museum",
            "Reserve Bank of New Zealand",
            "Rotorua Museum of Art & History Te Whare Taonga o Te Arawa",
            "Sarjeant Gallery Te Whare o Rehua Whanganui",
            "Science Learning Hub",
            "Science Media Centre",
            "Shantytown",
            "Silky Oak Museum",
            "Social Investment Agency",
            "SOUNZ",
            "South Canterbury Museum",
            "SPARC",
            "State Library of New South Wales",
            "State Library of Victoria",
            "Statistics New Zealand",
            "Tauranga City Libraries",
            "TBHP Collective Holiday Memories",
            "Te Aroha & Districts Museum",
            "Te Awamutu Online",
            "Te Manawa",
            "Television New Zealand",
            "The British Library",
            "The Dowse Art Museum",
            "The National Archives UK",
            "The New Zealand Nursing Education and Research Foundation",
            "The Phoenix Project",
            "The Prow: ngā kōrero o te tau ihu",
            "The Spinoff",
            "The Treasury",
            "The University of Auckland Library",
            "Toitū Otago Settlers Museum",
            "Tourism New Zealand",
            "Trove",
            "Tusk - Emergent Culture",
            "UC QuakeStudies",
            "UCOL Universal College of Learning",
            "Unitec",
            "University of Canterbury",
            "University of Canterbury Library",
            "University of Otago",
            "University of Waikato",
            "Upper Hutt City Library",
            "V.C. Browne & Son",
            "Victoria University of Wellington",
            "Waikato Museum Te Whare Taonga o Waikato",
            "Waimakariri District Libraries",
            "Waimate Historical Museum and Archives",
            "Wairarapa Archive",
            "Waitangi Tribunal",
            "Waitangi Tribunal Unit",
            "Wallace Arts Trust",
            "Wanganui Collegiate School Museum",
            "Wellington City Council",
            "Wellington City Libraries",
            "Whanganui Regional Museum",
            "Whangarei Libraries",
            "What is that Christchurch",
            "Whitireia Community Polytechnic",
            "Wikimedia Commons",
            "Wikipedia"
        ]
        return partners
    }
    
    
}

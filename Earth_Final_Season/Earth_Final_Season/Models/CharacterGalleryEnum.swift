//
//  CharacterGalleryEnum.swift
//  Earth_Final_Season
//
//  Created by Larissa Fazolin on 26/11/24.
//

import Foundation
import SwiftUI
import Design_System

enum CharacterGallery: CaseIterable {
    case ultraNewAgeEnvironmentalist, slowLogisticsEngineer, experimentalistGeneticist,
         sensationalistTVHost, indiePhysician, chronicallyOnlineTeenager,
         questionableReligiousLeader, presidentInDenial, fearlessEconomist,
         evilResearcher, chaoticBillionaire, convincingConspiracyTheorist,
         apocalypticalCat, robotVacuumCleaner, lockedCharacter
    
    var name: String {
        switch self {
            case .ultraNewAgeEnvironmentalist: return "ULTRA NEW AGE ENVIRONMENTALIST"
            case .slowLogisticsEngineer: return "SLOW LOGISTICS ENGINEER"
            case .experimentalistGeneticist: return "EXPERIMENTALIST GENETICIST"
            case .sensationalistTVHost: return "SENSATIONALIST TV HOST"
            case .indiePhysician: return "INDIE PHYSICIAN"
            case .chronicallyOnlineTeenager: return "CHRONICALLY ONLINE TEENAGER"
            case .questionableReligiousLeader: return "QUESTIONABLE RELIGIOUS LEADER"
            case .presidentInDenial: return "PRESIDENT IN DENIAL"
            case .fearlessEconomist: return "FEARLESS ECONOMIST"
            case .evilResearcher: return "EVIL RESEARCHER"
            case .chaoticBillionaire: return "CHAOTIC BILLIONAIRE"
            case .convincingConspiracyTheorist: return "CONVINCING CONSPIRACY THEORIST"
            case .apocalypticalCat: return "APOCALYPTICAL CAT"
            case .robotVacuumCleaner: return "ROBOT VACUUM CLEANER"
            case .lockedCharacter: return "???"
        }
    }
    
    var description: String {
        switch self {
            case .ultraNewAgeEnvironmentalist: return "Saves the planet... with crystals"
            case .slowLogisticsEngineer: return "Shipping delays? It’s a lifestyle"
            case .experimentalistGeneticist: return "Mixes DNA like a smoothie"
            case .sensationalistTVHost: return "Bringing you panic in HD, 24/7!"
            case .indiePhysician: return "Prescribes herbal tea and good vibes for broken bones"
            case .chronicallyOnlineTeenager: return "Hasn’t touched grass since 2020"
            case .questionableReligiousLeader: return "Has a \"prophecy\" for everything"
            case .presidentInDenial: return "Promises change... after the next election"
            case .fearlessEconomist: return "Calls a recession \"a growth opportunity\""
            case .evilResearcher: return "Mad? No, just… morally flexible"
            case .chaoticBillionaire: return "Buys planets. Forgets why"
            case .convincingConspiracyTheorist: return "Claims aliens control everything"
            case .apocalypticalCat: return "Bringer of doom, taker of naps"
            case .robotVacuumCleaner: return "Sweeps up dirt... and humanity"
            case .lockedCharacter: return "!@#CHARACTER#$%\n///###LOCKED###\\"
        }
    }
    
    var image: Image {
        switch self {
            case .ultraNewAgeEnvironmentalist: return Assets.Images.newGallery.swiftUIImage
            case .slowLogisticsEngineer: return Assets.Images.logisticsGallery.swiftUIImage
            case .experimentalistGeneticist: return Assets.Images.geneticistGallery.swiftUIImage
            case .sensationalistTVHost: return Assets.Images.tvGallery.swiftUIImage
            case .indiePhysician: return Assets.Images.indieGallery.swiftUIImage
            case .chronicallyOnlineTeenager: return Assets.Images.onlineGallery.swiftUIImage
            case .questionableReligiousLeader: return Assets.Images.religiousGallery.swiftUIImage
            case .presidentInDenial: return Assets.Images.presidentGallery.swiftUIImage
            case .fearlessEconomist: return Assets.Images.economistGallery.swiftUIImage
            case .evilResearcher: return Assets.Images.researcherGallery.swiftUIImage
            case .chaoticBillionaire: return Assets.Images.billionaireGallery.swiftUIImage
            case .convincingConspiracyTheorist: return Assets.Images.theoristGallery.swiftUIImage
            case .apocalypticalCat: return Assets.Images.catGallery.swiftUIImage
            case .robotVacuumCleaner: return Assets.Images.robotGallery.swiftUIImage
            case .lockedCharacter: return Assets.Images.lockedGallery.swiftUIImage
        }
    }
}

extension CharacterGallery {
    func isUnlocked(using unlockedNames: [String]) -> Bool {
        unlockedNames.contains(self.name.lowercased())
    }
}


enum EndingsGallery: CaseIterable {
    case environmentalDegradation, sociopoliticalInstability, illBeing,
    apocalypticalCat, robotVacuumCleaner, audience, lockedEnding
    
    func getDescritption() -> String {
        switch self {
        case .apocalypticalCat:
            return Constants.EndingsGalleryView.catDescription
            
        case .environmentalDegradation:
            return Constants.EndingsGalleryView.environmentDescription
            
        case .sociopoliticalInstability:
            return Constants.EndingsGalleryView.sociopoliticalDescription
            
        case .audience:
            return Constants.EndingsGalleryView.audienceDescription
            
        case .illBeing:
            return Constants.EndingsGalleryView.illBeingDescription
            
        case .robotVacuumCleaner:
            return Constants.EndingsGalleryView.robotDescription
        
        case .lockedEnding: return "!@#Ending#$%\n///###LOCKED###\\"
        }
    }
    
    var ending: String {
        switch self {
        case .apocalypticalCat:
            return "Apocalyptical Cat"
            
        case .environmentalDegradation:
            return "Environmental Degradation"
            
        case .sociopoliticalInstability:
            return "Sociopolitical Instability"
            
        case .audience:
            return "Audience"
            
        case .illBeing:
            return "IllBeing"
            
        case .robotVacuumCleaner:
            return "Robot Vacuum Cleaner"
        
        case .lockedEnding: return "ending not found"
        }
    }
    
    var image: Image {
        switch self {
        case .apocalypticalCat:
            return Assets.Images.specialFinalApocalypiticalCat.swiftUIImage
            
        case .environmentalDegradation:
            return Assets.Images.environmentalEnd.swiftUIImage
        
        case .illBeing:
            return Assets.Images.illBeingEnd.swiftUIImage
        
        case .sociopoliticalInstability:
            return Assets.Images.socioPoliticalEnd.swiftUIImage
            
        case .audience:
            return Assets.Images.audienceEnd.swiftUIImage
            
        case .robotVacuumCleaner:
            return Assets.Images.specialFinalRobotVaccum.swiftUIImage
            
        case .lockedEnding: return Assets.Images.lockedGallery.swiftUIImage
        }
    }
}

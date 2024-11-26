//
//  CharacterGalleryEnum.swift
//  Earth_Final_Season
//
//  Created by Larissa Fazolin on 26/11/24.
//

import Foundation
import SwiftUI
import Design_System

enum CharacterGallery {
    case ultraNewAgeEnvironmentalist, slowLogisticsEngineer, experimentalistGeneticist,
         sensationalistTVHost, indiePhysician, chronicallyOnlineTeenager,
         questionableReligiousLeader, presidentInDenial, fearlessEconomist,
         evilResearcher, chaoticBillionaire, convincingConspiracyTheorist,
         apocalypticalCat, robotVacuumCleaner, lockedCharacter
    
    var name: String {
        switch self {
            case .ultraNewAgeEnvironmentalist: return "Ultra New Age Environmentalist"
            case .slowLogisticsEngineer: return "Slow Logistics Engineer"
            case .experimentalistGeneticist: return "Experimentalist Geneticist"
            case .sensationalistTVHost: return "Sensationalist TV Host"
            case .indiePhysician: return "Indie Physician"
            case .chronicallyOnlineTeenager: return "Chronically Online Teenager"
            case .questionableReligiousLeader: return "Questionable Religious Leader"
            case .presidentInDenial: return "President in Denial"
            case .fearlessEconomist: return "Fearless Economist"
            case .evilResearcher: return "Evil Researcher"
            case .chaoticBillionaire: return "Chaotic Billionaire"
            case .convincingConspiracyTheorist: return "Convincing Conspiracy Theorist"
            case .apocalypticalCat: return "Apocalyptical Cat"
            case .robotVacuumCleaner: return "Robot Vacuum Cleaner"
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
            case .lockedCharacter: return "!@#ERROR#$%\n///###UNKNOWN###\\"
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

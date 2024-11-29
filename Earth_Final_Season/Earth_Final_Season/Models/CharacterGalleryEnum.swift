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
    
    func name(isPortuguese: Bool) -> String {
        switch self {
            case .ultraNewAgeEnvironmentalist: return isPortuguese ? "AMBIENTALISTA MÍSTICA QUÂNTICA" : "ULTRA NEW AGE ENVIRONMENTALIST"
            case .slowLogisticsEngineer: return isPortuguese ? "ENGENHEIRO LOGÍSTICO LENTO" : "SLOW LOGISTICS ENGINEER"
            case .experimentalistGeneticist: return isPortuguese ? "GENETICISTA EXPERIMENTALISTA" : "EXPERIMENTALIST GENETICIST"
            case .sensationalistTVHost: return isPortuguese ? "APRESENTADOR DE TV SENSACIONALISTA" : "SENSATIONALIST TV HOST"
            case .indiePhysician: return isPortuguese ? "MÉDICO ALTERNATIVO" : "INDIE PHYSICIAN"
            case .chronicallyOnlineTeenager: return isPortuguese ? "ADOLESCENTE CRONICAMENTE ONLINE" : "CHRONICALLY ONLINE TEENAGER"
            case .questionableReligiousLeader: return isPortuguese ? "LÍDER RELIGIOSO QUESTIONÁVEL" : "QUESTIONABLE RELIGIOUS LEADER"
            case .presidentInDenial: return isPortuguese ? "PRESIDENTE EM NEGAÇÃO" : "PRESIDENT IN DENIAL"
            case .fearlessEconomist: return isPortuguese ? "ECONOMISTA DESTEMIDO" : "FEARLESS ECONOMIST"
            case .evilResearcher: return isPortuguese ? "PESQUISADOR DO MAL" : "EVIL RESEARCHER"
            case .chaoticBillionaire: return isPortuguese ? "BILIONÁRIO CAÓTICO" : "CHAOTIC BILLIONAIRE"
            case .convincingConspiracyTheorist: return isPortuguese ? "CONSPIRACIONISTA CONVINCENTE" : "CONVINCING CONSPIRACY THEORIST"
            case .apocalypticalCat: return isPortuguese ? "GATO APOCALÍPTICO" : "APOCALYPTICAL CAT"
            case .robotVacuumCleaner: return isPortuguese ? "ROBÔ ASPIRADOR" : "ROBOT VACUUM CLEANER"
            case .lockedCharacter: return "???"
        }
    }
    
    func description(isPortuguese: Bool) -> String {
        switch self {
            case .ultraNewAgeEnvironmentalist:
                return isPortuguese ? "Salva o planeta... com cristais" : "Saves the planet... with crystals"
            case .slowLogisticsEngineer:
                return isPortuguese ? "Atrasos na entrega? É um estilo de vida" : "Shipping delays? It’s a lifestyle"
            case .experimentalistGeneticist:
                return isPortuguese ? "Mistura DNA como se fosse um milkshake" : "Mixes DNA like a smoothie"
            case .sensationalistTVHost:
                return isPortuguese ? "Trazendo pânico em HD, 24h por dia!" : "Bringing you panic in HD, 24/7!"
            case .indiePhysician:
                return isPortuguese ? "Prescreve chá de ervas e boas vibrações para ossos quebrados" : "Prescribes herbal tea and good vibes for broken bones"
            case .chronicallyOnlineTeenager:
                return isPortuguese ? "Não pisa na grama desde 2020" : "Hasn’t touched grass since 2020"
            case .questionableReligiousLeader:
                return isPortuguese ? "Tem uma \"profecia\" para tudo" : "Has a \"prophecy\" for everything"
            case .presidentInDenial:
                return isPortuguese ? "Promete mudanças... depois da próxima eleição" : "Promises change... after the next election"
            case .fearlessEconomist:
                return isPortuguese ? "Chama uma recessão de \"oportunidade de crescimento\"" : "Calls a recession \"a growth opportunity\""
            case .evilResearcher:
                return isPortuguese ? "Louco? Não, apenas... moralmente flexível" : "Mad? No, just… morally flexible"
            case .chaoticBillionaire:
                return isPortuguese ? "Compra planetas. Esquece o porquê" : "Buys planets. Forgets why"
            case .convincingConspiracyTheorist:
                return isPortuguese ? "Diz que alienígenas controlam tudo" : "Claims aliens control everything"
            case .apocalypticalCat:
                return isPortuguese ? "Destruidor de mundos, amante de caixas" : "Bringer of doom, taker of naps"
            case .robotVacuumCleaner:
                return isPortuguese ? "Aspira sujeira... e a humanidade" : "Sweeps up dirt... and humanity"
            case .lockedCharacter:
                return isPortuguese ? "!@#PERSONAGEM#$%\n###BLOQUEADO###\\" : "!@#CHARACTER#$%\n///###LOCKED###\\"
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
    func isUnlocked(using unlockedNames: [String], isPortuguese: Bool) -> Bool {
        unlockedNames.contains(self.name(isPortuguese: isPortuguese).lowercased())
    }
}

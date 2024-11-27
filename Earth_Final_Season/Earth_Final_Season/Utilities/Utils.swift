//
//  Utils.swift
//  Earth_Final_Season
//
//  Created by Breno Harris on 13/11/24.
//

import Foundation
import Design_System
import SwiftUI

struct Utils {
    
    static func isSpecialCharacter(_ name: String?) -> Bool {
        guard let characterName = name else { return false }
        switch characterName.lowercased() {
        case "apocalyptical cat", "robot vacuum cleaner":
            return true
        
        default:
            return false
        }
    }
    static func switchMessageDependingOnCharacter(_ name: String?) -> (title: String, message: String){
        let defaultMessage = (title: "nope", message: "something's gone wrong")
        guard let characterName = name else { return defaultMessage }
        
        switch characterName.lowercased() {
        case "apocalyptical cat":
            return (title: Constants.GameEngine.gameOverCatTitle , message: Constants.GameEngine.gameOverCatMessage)
        
        case "robot vacuum cleaner":
            return (title: Constants.GameEngine.gameOverRobotVacuumCleanerTitle , message: Constants.GameEngine.gameOverRobotVacuumCleanerMessage)
            
        default:
            return defaultMessage
            
        }
    }
    
    static func getImageByName(_ characterName: String) -> Image {
        switch characterName.lowercased() {
        case "ultra new age environmentalist":
            return Assets.Images.ultraNewAgeEnvironmentalist.swiftUIImage
        case "fearless economist":
            return Assets.Images.fearlessEconomist.swiftUIImage
            
        case "apocalyptical cat":
            return Assets.Images.apocalypticalCat.swiftUIImage
            
        case "special final apocalyptical cat":
            return Assets.Images.specialFinalApocalypiticalCat.swiftUIImage
            
        case "chronically online teenager":
            return Assets.Images.chronicallyOnlineTeenager.swiftUIImage
            
        case "conspiracy theorist":
            return Assets.Images.conspiracyTheoristPodcaster.swiftUIImage
            
        case "chaotic billionaire":
            return Assets.Images.chaocticBillionaire.swiftUIImage
            
        case "evil researcher":
            return Assets.Images.evilResearcher.swiftUIImage
            
        case "experimentalist geneticist":
            return Assets.Images.experimentalistGeneticist.swiftUIImage
            
        case "indie physician":
            return Assets.Images.indiePhysician.swiftUIImage
            
        case "president in denial":
            return Assets.Images.presidentInDenial.swiftUIImage
            
        case "questionable religious leader":
            return Assets.Images.questionableReligiousLeader.swiftUIImage
            
        case "robot vacuum cleaner":
            return Assets.Images.robotVacumCleaner.swiftUIImage
            
        case "special final robot vacuum cleaner":
            return Assets.Images.specialFinalRobotVaccum.swiftUIImage
            
        case "sensationalist tv host":
            return Assets.Images.sensionalistTVHost.swiftUIImage
            
        case "slow logistics engineer":
            return Assets.Images.slowLogisticEngineer.swiftUIImage
            
        default:
            return Image("image1")
        }
    }
}

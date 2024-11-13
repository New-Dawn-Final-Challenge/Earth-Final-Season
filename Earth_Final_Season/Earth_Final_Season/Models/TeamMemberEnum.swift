//
//  TeamMemberEnum.swift
//  Earth_Final_Season
//
//  Created by Larissa Fazolin on 13/11/24.
//

import Foundation
import SwiftUI
import Design_System

enum TeamMember {
    case elisa, breno, bruna, lariF, lariO, luan
    
    var name: String {
        switch self {
        case .elisa:
            return "Ana Elisa"
        case .breno:
            return "Breno Harris"
        case .bruna:
            return "Bruna Lacerda"
        case .lariF:
            return "Larissa Fazolin"
        case .lariO:
            return "Larissa Okabayashi"
        case .luan:
            return "Luan Fazolin"
        }
    }
    
    var role: String {
        switch self {
        case .elisa:
            return "Developer"
        case .breno:
            return "Developer"
        case .bruna:
            return "Designer"
        case .lariF:
            return "Developer"
        case .lariO:
            return "Developer"
        case .luan:
            return "Designer"
        }
    }
    
    var image: Image {
        switch self {
        case .elisa:
            return Assets.Images.elisa.swiftUIImage
        case .breno:
            return Assets.Images.breno.swiftUIImage
        case .bruna:
            return Assets.Images.bruna.swiftUIImage
        case .lariF:
            return Assets.Images.lariF.swiftUIImage
        case .lariO:
            return Assets.Images.lariO.swiftUIImage
        case .luan:
            return Assets.Images.luan.swiftUIImage
        }
    }
}

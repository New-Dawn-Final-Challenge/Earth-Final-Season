//
//  FontsModel.swift
//  Earth_Final_Season
//
//  Created by Larissa Fazolin on 21/10/24.
//

import SwiftUI

extension Font {
    static var hugeTitleFont: Font {
        return .custom("ShareTechMono-Regular", size: 70)
    }
    
    static var largeTitleFont: Font {
        return .custom("ShareTechMono-Regular", size: UIFont.preferredFont(forTextStyle: .largeTitle).pointSize)
    }
    
    static var title1Font: Font {
        return .custom("ShareTechMono-Regular", size: UIFont.preferredFont(forTextStyle: .title1).pointSize)
    }
    static var title2Font: Font {
        return .custom("ShareTechMono-Regular", size: UIFont.preferredFont(forTextStyle: .title2).pointSize)
    }
    
    static var title3Font: Font {
        return .custom("ShareTechMono-Regular", size: UIFont.preferredFont(forTextStyle: .title3).pointSize)
    }
    
    static var bodyFont: Font {
        return .custom("ShareTechMono-Regular", size: UIFont.preferredFont(forTextStyle: .body).pointSize)
    }
    
    static var headlineFont: Font {
        return .custom("ShareTechMono-Regular", size: UIFont.preferredFont(forTextStyle: .headline).pointSize)
    }
    
    static var footnoteFont: Font {
        return .custom("ShareTechMono-Regular", size: UIFont.preferredFont(forTextStyle: .footnote).pointSize)
    }
}

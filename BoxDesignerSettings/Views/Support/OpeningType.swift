//
//  OpeningType.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/10/22.
//

import Foundation

enum OpeningType: String, CaseIterable, Codable {
    case slot = "Slot"
    case opening = "Opening"
    
    var systemImageName: String {
        switch self {
        case .slot:
            return SystemImageNames.slots
        case .opening:
            return SystemImageNames.openings
        }
    }
}

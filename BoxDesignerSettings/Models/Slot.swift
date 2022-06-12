//
//  Holes.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/1/22.
//

import Foundation

enum SlotType: String, CaseIterable, Codable {
    case circle = "Circle"
    case ellipse = "Ellipse"
    case square = "Square"
    case rectangle = "Rectangle"
    case capsule = "Capsule"
}

struct Slot: Identifiable, Codable {
    let id: String
    var type: SlotType
    var dimension1: Double
    var dimension2: Double
    var xOffset: Double
    var yOffset: Double
    
    init(id: String = UUID().uuidString,
         type: SlotType = .circle,
         dimension1: Double = 0.0,
         dimension2: Double = 0.0,
         xOffset: Double = 0.0,
         yOffset: Double = 0.0) {
        self.id = id
        self.type = type
        self.dimension1 = dimension1
        self.dimension2 = dimension2
        self.xOffset = xOffset
        self.yOffset = yOffset
    }
    
    var description: String {
        "\(type.rawValue) (\(xOffset), \(yOffset))"
    }
    
    var width: Double {
        dimension1
    }
    
    var height: Double {
        switch type {
        case .circle, .square:
            return dimension1
        default:
            return dimension2
        }
    }
}

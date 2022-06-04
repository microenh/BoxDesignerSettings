//
//  Holes.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/1/22.
//

import Foundation

enum SlotType: String, CaseIterable, Codable, Equatable, Hashable {
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
    var xCenter: Double
    var yCenter: Double
    var rotation: Double
    
    init(id: String = UUID().uuidString,
         type: SlotType = .circle,
         dimension1: Double = 0.0,
         dimension2: Double = 0.0,
         xCenter: Double = 0.0,
         yCenter: Double = 0.0,
         rotation: Double = 0.0) {
        self.id = id
        self.type = type
        self.dimension1 = dimension1
        self.dimension2 = dimension2
        self.xCenter = xCenter
        self.yCenter = yCenter
        self.rotation = rotation
    }
    
    var description: String {
        "\(type.rawValue) (\(xCenter), \(yCenter))"
    }
}

//
//  Holes.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/1/22.
//

import Foundation

enum HoleType: Codable {
    case circle(diameter: Double)
    case ellipse(xWidth: Double, yWidth: Double)
    case square(side: Double)
    case rectangle(xSide: Double, ySide: Double)
    case capsule(xSize: Double, ySize: Double)
    case opening(id: String)
}

struct Hole: Identifiable, Codable {
    let id: String
    var type: HoleType
    var xCenter: Double
    var yCenter: Double
    
    init(type: HoleType = .circle(diameter: 0.0), xCenter: Double = 0.0, yCenter: Double = 0.0) {
        self.type = type
        self.id = UUID().uuidString
        self.xCenter = xCenter
        self.yCenter = yCenter
    }
    
    var description: String {
        switch type {
        case .circle:
            return "Circle"
        case .ellipse:
            return "Ellipse"
        case .square:
            return "Square"
        case .rectangle:
            return "Rectangle"
        case .capsule:
            return "Capsule"
        case .opening:
            return "Opening"
        }
    }
    
}

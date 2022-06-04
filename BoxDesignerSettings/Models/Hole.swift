//
//  Holes.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/1/22.
//

import Foundation

enum HoleType: Codable, Hashable {
    case circle(diameter: Double)
    case ellipse(xWidth: Double, yWidth: Double)
    case square(side: Double)
    case rectangle(xSide: Double, ySide: Double)
    case capsule(xSize: Double, ySize: Double)
    case opening(id: String)
    
    var description: String {
        switch self {
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
    
    var rawValue: Int {
        get {
            switch self {
            case .circle:
                return 0
            case .ellipse:
                return 1
            case .square:
                return 2
            case .rectangle:
                return 3
            case .capsule:
                return 4
            case .opening:
                return 5
            }
        }
        set {
            switch newValue {
            case 0:
                self = .circle(diameter: 0)
            case 1:
                self = .ellipse(xWidth: 0.0, yWidth: 0.0)
            case 2:
                self = .square(side: 0.0)
            case 3:
                self = .rectangle(xSide: 0.0, ySide: 0.0)
            case 4:
                self = .capsule(xSize: 0.0, ySize: 0.0)
            case 5:
                self = .opening(id: UUID().uuidString)
            default:
                break
            }
        }
    }

}


struct Hole: Identifiable, Codable {
    let id: String
    var type: HoleType
    var xCenter: Double
    var yCenter: Double
    
    init(type: HoleType = .circle(diameter: 0.0), xCenter: Double = 0.0, yCenter: Double = 0.0) {
        self.id = UUID().uuidString
        self.type = type
        self.xCenter = xCenter
        self.yCenter = yCenter
    }
    
    var description: String {
        type.description
    }
}

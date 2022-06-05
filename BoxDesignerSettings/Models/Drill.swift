//
//  DrillsModel.swift
//  BoxDesignerDoc
//
//  Created by Mark Erbaugh on 5/26/22.
//

import Foundation

struct Drill: Codable, Identifiable, Hashable {
    let id: String
    var type: String
    var diameter: Double
    var flutes: Int
    var verticalSpeed: Double
    var depthPerPass: Double
    var conventional: Bool
    
    init(id: String = UUID().uuidString,
         type: String = "",
         diameter: Double = 0.0,
         flutes: Int = 0,
         verticalSpeed: Double = 0.0,
         depthPerPass: Double = 0.0,
         conventional: Bool = true) {
        self.id = id
        self.type = type
        self.diameter = diameter
        self.flutes = flutes
        self.verticalSpeed = verticalSpeed
        self.depthPerPass = depthPerPass
        self.conventional = conventional
    }
    
    var description: String {
        "\(type) (\(diameter)mm)"
    }
}

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
    var minChipLoad: Double
    var maxChipLoad: Double
    var verticalSpeed: Double
    var depthPerPass: Double
    var conventional: Bool
    
    init(id: String = "D" + UUID().uuidString,
         type: String = "",
         diameter: Double = 0.0,
         flutes: Int = 0,
         minChipLoad: Double = 0.0,
         maxChipLoad: Double = 0.0,
         verticalSpeed: Double = 0.0,
         depthPerPass: Double = 0.0,
         conventional: Bool = true) {
        self.id = id
        self.type = type
        self.diameter = diameter
        self.flutes = flutes
        self.minChipLoad = minChipLoad
        self.maxChipLoad = maxChipLoad
        self.verticalSpeed = verticalSpeed
        self.depthPerPass = depthPerPass
        self.conventional = conventional
    }
    
    var name: String {
        "\(diameter) mm \(type)"
    }
}

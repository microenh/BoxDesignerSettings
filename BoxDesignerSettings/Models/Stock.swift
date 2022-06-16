//
//  Stock.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/15/22.
//

import Foundation

struct StockFace: Identifiable, Codable {
    let id: String
    var face: Face
    var xOffset: Double
    var yOffset: Double
    var rotated: Bool
    
    init(id: String = UUID().uuidString,
         face: Face = .front,
         xOffset: CGFloat = 0,
         yOffset: CGFloat = 0,
         rotated: Bool = false) {
        self.id = id
        self.face = face
        self.xOffset = xOffset
        self.yOffset = yOffset
        self.rotated = rotated
    }
}

struct StockLayout: Identifiable, Codable {
    let id: String
    var stockFaces: [String: StockFace]
    
    init(id: String = UUID().uuidString,
         stockFaces: [String: StockFace] = [String: StockFace]()) {
        self.id = id
        self.stockFaces = stockFaces
    }
}

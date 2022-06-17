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
    var offsetX: Double
    var offsetY: Double
    var rotated: Bool
    
    init(id: String = UUID().uuidString,
         face: Face = .front,
         offsetX: CGFloat = 0,
         offsetY: CGFloat = 0,
         rotated: Bool = false) {
        self.id = id
        self.face = face
        self.offsetX = offsetX
        self.offsetY = offsetY
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

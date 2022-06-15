//
//  Stock.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/15/22.
//

import Foundation

struct Stock: Identifiable, Codable {
    let id: String
    var face: Face
    var xOffset: CGFloat
    var yOffset: CGFloat
    var rotated: Bool
}

struct StockLayout: Identifiable, Codable {
    let id: String
    var layout: [String: Stock]
}

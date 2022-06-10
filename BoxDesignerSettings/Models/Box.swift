//
//  Box.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/8/22.
//

import Foundation

struct OpeningWrapper: Identifiable, Codable {
    let id: String
    var xCenter: Double
    var yCenter: Double
}

struct BoxModel: Codable {
    var comment: String
    var front: Bool
    var rear: Bool
    var left: Bool
    var right: Bool
    var top: Bool
    var bottom: Bool
    var width: Double
    var height: Double
    var depth: Double
    var stockWidth: Double
    var stockLength: Double
    var stockThickness: Double
    var fingerMultiple: Double
    var materialId: String
    var roughDrill: String
    var finishDrill: String
    
    var frontSlots: [Slot]
    var rearSlots: [Slot]
    var leftSlots: [Slot]
    var rightSlots: [Slot]
    var topSlots: [Slot]
    var bottomSlots: [Slot]
    
    var frontOpenings: [OpeningWrapper]
    var rearOpenings: [OpeningWrapper]
    var leftOpenings: [OpeningWrapper]
    var rightOpenings: [OpeningWrapper]
    var topOpenings: [OpeningWrapper]
    var bottomOpenings: [OpeningWrapper]
    
    init() {
        comment = ""
        front = true
        rear = true
        left = true
        right = true
        top = true
        bottom = true
        width = 0.0
        height = 0.0
        depth = 0.0
        stockWidth = 0.0
        stockLength = 0.0
        stockThickness = 0.0
        fingerMultiple = 0.0
        materialId = ""
        roughDrill = ""
        finishDrill = ""
        frontSlots = [Slot]()
        rearSlots = [Slot]()
        leftSlots = [Slot]()
        rightSlots = [Slot]()
        topSlots = [Slot]()
        bottomSlots = [Slot]()
        frontOpenings = [OpeningWrapper]()
        rearOpenings = [OpeningWrapper]()
        leftOpenings = [OpeningWrapper]()
        rightOpenings = [OpeningWrapper]()
        topOpenings = [OpeningWrapper]()
        bottomOpenings = [OpeningWrapper]()
    }
}

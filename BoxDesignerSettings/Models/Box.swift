//
//  Box.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/8/22.
//

import Foundation

struct OpeningWrapper: Identifiable, Codable {
    let id: String
    var openingId: String
    var xOffset: Double
    var yOffset: Double
    
    init(id: String = UUID().uuidString,
         openingId: String = "",
         xOffset: Double = 0.0,
         yOffset: Double = 0.0) {
        self.id = id
        self.openingId = openingId
        self.xOffset = xOffset
        self.yOffset = yOffset
    }
}

struct BoxModel: Codable {
    var comment: String
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
    
    var sides: [Face: Bool]
    var slots: [Face: [String: Slot]]
    var openings: [Face: [String: OpeningWrapper]]
    var stockLayouts: [String: StockLayout]
    
    init() {
        comment = ""
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
        slots = [.front: [String: Slot](),
                 .rear: [String: Slot](),
                 .left: [String: Slot](),
                 .right: [String: Slot](),
                 .top: [String: Slot](),
                 .bottom: [String: Slot]()]
        openings = [.front: [String: OpeningWrapper](),
                    .rear: [String: OpeningWrapper](),
                    .left: [String: OpeningWrapper](),
                    .right: [String: OpeningWrapper](),
                    .top: [String: OpeningWrapper](),
                    .bottom: [String: OpeningWrapper]()]
        sides = [.front: true,
                 .rear: true,
                 .left: true,
                 .right: true,
                 .top: true,
                 .bottom: true]
        stockLayouts = [String: StockLayout]()
    }
    
    var front: Bool {
        get { sides[.front]! }
        set { sides[.front] = newValue }
    }
    
    var rear: Bool {
        get { sides[.rear]! }
        set { sides[.rear] = newValue }
    }
    
    var left: Bool {
        get { sides[.left]! }
        set { sides[.left] = newValue }
    }
    
    var right: Bool {
        get { sides[.right]! }
        set { sides[.right] = newValue }
    }
    
    var top: Bool {
        get { sides[.top]! }
        set { sides[.top] = newValue }
    }
    
    var bottom: Bool {
        get { sides[.bottom]! }
        set { sides[.bottom] = newValue }
    }
    
    func size(face: Face) -> CGSize {
        var width: CGFloat
        var height: CGFloat
        switch face {
        case .front, .rear:
            width = self.width
            height = self.height
        case .left, .right:
            width = self.depth
            height = self.height
        case .top, .bottom:
            width = self.width
            height = self.depth
        }
        return CGSize(width: width, height: height)
    }
    
    mutating func addOpening(face: Face) -> String {
        let item = OpeningWrapper()
        openings[face]![item.id] = item
        return item.id
    }
    
    mutating func deleteOpening(face: Face, selection: String) {
        openings[face]![selection] = nil
     }
    
    mutating func addSlot(face: Face) -> String {
        let item = Slot()
        slots[face]![item.id] = item
        return item.id
    }
    
    mutating func deleteSlot(face: Face, selection: String) {
        slots[face]![selection] = nil
    }
}

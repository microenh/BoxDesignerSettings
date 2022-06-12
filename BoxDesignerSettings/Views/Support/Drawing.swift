//
//  OpeningDrawing.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/6/22.
//

import Foundation
import SwiftUI

struct Drawing {
    static func boxScale(size: CGSize, width: CGFloat, height: CGFloat) -> CGFloat {
        guard size.width > 0, size.height > 0, width > 0, height > 0 else {
            return 1.0
        }
        return min((size.width - 2) / width, (size.height - 2) / height)
    }
    
    static func openingScale(size: CGSize, item: Opening) -> CGFloat {
        guard item.detailItems.count > 0 else {
            return 1
        }
        var maxX: CGFloat = 1
        var maxY: CGFloat = 1
        
        for hole in item.detailItems.values {
            maxX = max(maxX, hole.xOffset + hole.width)
            maxY = max(maxY, hole.yOffset + hole.height)
        }
        return min(size.width / maxX, size.height / maxY)
     }
    
    static let lineWidth = CGFloat(0.25)
    static let inset: CGFloat = 10
    
    static func drawOpening(context: GraphicsContext, item: Opening, scale: CGFloat, offset: CGPoint) {
        for hole in item.detailItems.values {
            let rect = CGRect(x: (offset.x + hole.xOffset) * scale, y: (offset.y + hole.yOffset) * scale, width: hole.width * scale, height: hole.height * scale)
//            print ("rect \(rect)")
            var path: Path
            switch hole.type {
            case .circle, .ellipse:
                path = Path(ellipseIn: rect)
            case .square, .rectangle:
                path = Path(rect)
            case .capsule:
                path = Path(roundedRect: rect, cornerRadius: min(hole.width, hole.height) * scale / 2)
            }
            context.stroke(path, with: .color(.primary), lineWidth: Self.lineWidth)
        }
    }
    
    static func drawSide(context: GraphicsContext, size: CGSize, face: Face, box: BoxModel, openings: Openings, selection: String?) {
        guard box.sides[face]! else {
            return
        }
        var width: CGFloat
        var height: CGFloat
        switch face {
        case .front, .rear:
            width = box.width
            height = box.height
        case .left, .right:
            width = box.depth
            height = box.height
        case .top, .bottom:
            width = box.width
            height = box.depth
         }
        let scale = Self.boxScale(size: size, width: width, height: height)
        let center = CGPoint(x: size.width / 2 + 1, y: -size.height / 2  + 1)
        let origin = CGPoint(x: center.x - width / 2 * scale + 1, y: center.y + height / 2 * scale + 1)
        var path: Path
        path = Path(CGRect(origin: origin, size: CGSize(width: width * scale, height: height * scale)))
        context.stroke(path, with: .color(.primary), lineWidth: Self.lineWidth)
        for openingWrapper in box.openings[face]!.values {
            if let opening = openings[openingWrapper.openingId] {
                let center = CGPoint(x: origin.x + openingWrapper.xCenter * scale, y: origin.y - openingWrapper.yCenter * scale)
                Self.drawOpening(context: context, item: opening, scale: scale, offset: center)
            }
        }
    }
}

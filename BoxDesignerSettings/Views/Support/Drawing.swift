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
        return min(size.width / width, size.height / height)
    }
    
    static func openingScale(size: CGSize, item: Opening) -> CGFloat {
        var xWidthPlus: CGFloat = 0.5
        var yWidthPlus: CGFloat = 0.5
        var xWidthMinus: CGFloat = -0.5
        var yWidthMinus: CGFloat = -0.5
        var width: CGFloat
        var height: CGFloat
        for hole in item.detailItems.values {
            switch hole.type {
            case .circle, .square:
                width = hole.dimension1
                height = width
            case .ellipse, .rectangle, .capsule:
                width = hole.dimension1
                height = hole.dimension2
            }
            width /= 2
            height /= 2
            if hole.xOffset < 0 {
                xWidthMinus = min(xWidthMinus, hole.xOffset - width)
            } else {
                xWidthPlus = max(xWidthPlus, hole.xOffset + width)
            }
            if hole.yOffset < 0 {
                yWidthMinus = min(yWidthMinus, hole.yOffset - height)
            } else {
                yWidthPlus = max(yWidthPlus, hole.yOffset + height)
            }
        }
        return min(size.width / (xWidthPlus - xWidthMinus), size.height / (yWidthPlus - yWidthMinus))
     }
    
    static let lineWidth = CGFloat(0.25)
    
    static func drawOpening(context: GraphicsContext, size: CGSize, item: Opening, scale: CGFloat, center: CGPoint) {
        var width: CGFloat
        var height: CGFloat
        for hole in item.detailItems.values {
            switch hole.type {
            case .circle, .square:
                width = hole.dimension1
                height = width
            case .ellipse, .rectangle, .capsule:
                width = hole.dimension1
                height = hole.dimension2
            }
            let origin = CGPoint(x: center.x + (hole.xOffset - width / 2) * scale,
                                 y: center.y + (hole.yOffset - height / 2) * scale)
            let rect = CGRect(origin: origin, size: CGSize(width: width * scale, height: height * scale))
                .insetBy(dx: Self.lineWidth / 2, dy: Self.lineWidth / 2)
            
            var path: Path
            switch hole.type {
            case .circle, .ellipse:
                path = Path(ellipseIn: rect)
            case .square, .rectangle:
                path = Path(rect)
            case .capsule:
                path = Path(roundedRect: rect, cornerRadius: min(width, height) * scale / 2)
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
        let center = CGPoint(x: size.width / 2, y: -size.height / 2)
        let origin = CGPoint(x: center.x - width / 2 * scale, y: center.y + height / 2 * scale)
        var path: Path
        path = Path(CGRect(origin: origin, size: CGSize(width: width * scale, height: height * scale)))
        context.stroke(path, with: .color(.primary), lineWidth: Self.lineWidth)
        for openingWrapper in box.openings[face]!.values {
            if let opening = openings[openingWrapper.openingId] {
                let center = CGPoint(x: origin.x + openingWrapper.xCenter * scale, y: origin.y - openingWrapper.yCenter * scale)
                Self.drawOpening(context: context, size: size, item: opening, scale: scale, center: center)
            }
        }
    }
}

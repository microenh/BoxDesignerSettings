//
//  OpeningDrawing.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/6/22.
//

import Foundation
import SwiftUI

extension OpeningDetail {
    private func calcScale(size: CGSize) -> CGFloat {
        var xWidthPlus: CGFloat = 0.5
        var yWidthPlus: CGFloat = 0.5
        var xWidthMinus: CGFloat = -0.5
        var yWidthMinus: CGFloat = -0.5
        var width: CGFloat
        var height: CGFloat
        for hole in item!.detailItems.values {
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
    
    func drawOpening(context: GraphicsContext, size: CGSize) {
        let centerX = size.width / 2
        let centerY = size.height / 2
        let scale = calcScale(size: size)
        var width: CGFloat
        var height: CGFloat
        for hole in item!.detailItems.values {
            switch hole.type {
            case .circle, .square:
                width = hole.dimension1
                height = width
            case .ellipse, .rectangle, .capsule:
                width = hole.dimension1
                height = hole.dimension2
            }
            let origin = CGPoint(x: centerX + (hole.xOffset - width / 2) * scale,
                                 y: centerY + (hole.yOffset - height / 2) * scale)
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

}

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
        guard width > 0, height > 0 else {
            return 1.0
        }
        return min(size.width / width, size.height / height)
    }

    static private func drawSlot(context: GraphicsContext, scale: CGFloat, offset: CGPoint, item: Slot, selection: String?) {
        var path: Path
        let rect = CGRect(x: item.xOffset * scale + offset.x,
                          y: item.yOffset * scale + offset.y,
                          width: item.width * scale,
                          height: item.height * scale)
            .insetBy(dx: Misc.lineWidth / 2, dy: Misc.lineWidth / 2)
        switch item.type {
        case .circle, .ellipse:
            path = Path(ellipseIn: rect)
        case .square, .rectangle:
            path = Path(rect)
        case .capsule:
            path = Path(roundedRect: rect, cornerRadius: min(item.width, item.height) * scale / 2)
        }
        context.stroke(path,
                       with: .color([item.id, "O"].contains(selection) ? Misc.highlightColor : Misc.normalColor),
                       lineWidth: Misc.lineWidth)
    }

    static private func drawOpening(context: GraphicsContext, scale: CGFloat, offset: CGPoint, item: Opening, selection: String?) {
        for slot in item.detailItems.values {
            drawSlot(context: context, scale: scale, offset: offset, item: slot, selection: selection)
        }
    }
    
    static func drawOpening(context: GraphicsContext, size: CGSize, item: Opening, selection: String?) {
        let itemSize = item.size
        let scale = min(size.width / itemSize.width, size.height / itemSize.height)
        let offset = CGPoint(x: (size.width - itemSize.width * scale) / 2,
                             y: (size.height - itemSize.height * scale) / 2)
        drawOpening(context: context, scale: scale, offset: offset, item: item, selection: selection)
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
        guard width > 0, height > 0 else {
            return
        }
        let scale = min(size.width / width, size.height / height)
        let offset = CGPoint(x: (size.width - width * scale) / 2,
                             y: (size.height - height * scale) / 2)

        let path = Path(CGRect(origin: offset, size: CGSize(width: width * scale, height: height * scale)).insetBy(dx: Misc.lineWidth / 2, dy: Misc.lineWidth / 2))
        context.stroke(path, with: .color(.primary), lineWidth: Misc.lineWidth)
        for openingWrapper in box.openings[face]!.values {
            if let opening = openings[openingWrapper.openingId] {
                drawOpening(context: context,
                            scale: scale,
                            offset: CGPoint(x: offset.x + scale * openingWrapper.xCenter, y: offset.y + scale * openingWrapper.yCenter),
                            item: opening,
                            selection: selection == openingWrapper.id ? "O" : "")
            }
        }
        for slot in box.slots[face]!.values {
            drawSlot(context: context,
                     scale: scale,
                     offset: CGPoint(x: offset.x + scale * slot.xOffset, y: offset.y + scale * slot.yOffset),
                     item: slot,
                     selection: selection)

        }
    }
}

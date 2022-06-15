//
//  OpeningDrawing.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/6/22.
//

import Foundation
import SwiftUI

struct Drawing {
    
    static func drawOpening(context: GraphicsContext, size: CGSize, item: Opening, selection: String?) {
        let openingSize = item.size
        guard openingSize.width > 0, openingSize.height > 0 else {
            return
        }
        let scale = min(size.width / openingSize.width, size.height / openingSize.height)
        let offsetX = (size.width - openingSize.width * scale) / 2
        let offsetY = (size.height - openingSize.height * scale) / 2
        let translation = CGAffineTransform(translationX: offsetX, y: offsetY)
            .scaledBy(x: scale, y: scale)

        var path = Path()
        
        for slot in item.detailItems.values {
            if slot.id != selection {
                addSlot(path: &path, slot: slot)
            }
        }
        context.stroke(path.applying(translation),
                       with: .color(Misc.normalColor),
                       lineWidth: Misc.lineWidth)
        
        path = Path()
        for slot in item.detailItems.values {
            if slot.id == selection {
                addSlot(path: &path, slot: slot)
            }
        }
        context.stroke(path.applying(translation),
                       with: .color(Misc.highlightColor),
                       lineWidth: Misc.lineWidth)
    }
        
    static private func addSlot(path: inout Path, slot: Slot) {
        let rect = CGRect(x: slot.xOffset,
                          y: slot.yOffset,
                          width: slot.width,
                          height: slot.height)
            // .insetBy(dx: Misc.lineWidth / 2, dy: Misc.lineWidth / 2)
        switch slot.type {
        case .circle, .ellipse:
            path.addEllipse(in: rect)
        case .square, .rectangle:
            path.addRect(rect)
        case .capsule:
            let cornerSize = min(slot.width, slot.height) / 2
            path.addRoundedRect(in: rect, cornerSize: CGSize(width: cornerSize, height: cornerSize))
        }
    }
    
    static private func addOpening(path: inout Path, opening: Opening, xOffset: CGFloat, yOffset: CGFloat) {
        var lPath = Path()
        
        for slot in opening.detailItems.values {
            addSlot(path: &lPath, slot: slot)
        }
        lPath = lPath.applying(CGAffineTransform(translationX: xOffset, y: yOffset))
        path.addPath(lPath)
    }
    
    static func sidePaths(face: Face, box: BoxModel, openings: Openings, selection: String?) -> (normal: Path, highlight: Path) {
        let faceSize = box.size(face: face)
        var normalPath = Path()
        normalPath.addRect(CGRect(x: 0, y: 0, width: faceSize.width, height: faceSize.height))
        for openingWrapper in box.openings[face]!.values {
            if let opening = openings[openingWrapper.openingId],
               openingWrapper.id != selection {
                addOpening(path: &normalPath, opening: opening, xOffset: openingWrapper.xOffset, yOffset: openingWrapper.yOffset)
            }
        }
        
        for slot in box.slots[face]!.values {
            if slot.id != selection {
                addSlot(path: &normalPath, slot: slot)
            }
        }
 
        var highlightPath = Path()
        for openingWrapper in box.openings[face]!.values {
            if openingWrapper.id == selection,
               let opening = openings[openingWrapper.openingId] {
                addOpening(path: &highlightPath, opening: opening, xOffset: openingWrapper.xOffset, yOffset: openingWrapper.yOffset)
            }
        }
        for slot in box.slots[face]!.values {
            if slot.id == selection {
                addSlot(path: &highlightPath, slot: slot)
            }
        }
        return (normalPath, highlightPath)
    }
    
    static func drawSide(context: GraphicsContext, size: CGSize, face: Face, box: BoxModel, openings: Openings, selection: String?) {
        guard box.sides[face]! else {
            return
        }
        let faceSize = box.size(face: face)
        guard faceSize.width > 0, faceSize.height > 0 else {
            return
        }
        let scale = min(size.width / faceSize.width, size.height / faceSize.height)
        let offsetX = (size.width - faceSize.width * scale) / 2
        let offsetY = (size.height - faceSize.height * scale) / 2
        let translation = CGAffineTransform(translationX: offsetX, y: offsetY)
            .scaledBy(x: scale, y: scale)
        
        let (normal, highlight) = sidePaths(face: face, box: box, openings: openings, selection: selection)
        context.stroke(normal.applying(translation),
                       with: .color(Misc.normalColor),
                       lineWidth: Misc.lineWidth)
        
        context.stroke(highlight.applying(translation),
                       with: .color(Misc.highlightColor),
                       lineWidth: Misc.lineWidth)
    }
}

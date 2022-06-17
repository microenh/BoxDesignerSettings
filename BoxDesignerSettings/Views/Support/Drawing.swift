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
    
    static private func sidePath(face: Face, box: BoxModel, openings: Openings) -> Path{
        let faceSize = box.size(face: face)
        var path = Path()
        path.addRect(CGRect(x: 0, y: 0, width: faceSize.width, height: faceSize.height))
        for openingWrapper in box.openings[face]!.values {
            if let opening = openings[openingWrapper.openingId] {
                addOpening(path: &path, opening: opening, xOffset: openingWrapper.xOffset, yOffset: openingWrapper.yOffset)
            }
        }
        
        for slot in box.slots[face]!.values {
            addSlot(path: &path, slot: slot)
        }
        return path
    }

    
    static private func highlightPath(face: Face, box: BoxModel, openings: Openings, selection: String?) -> Path {
        var path = Path()
        for openingWrapper in box.openings[face]!.values {
            if let opening = openings[openingWrapper.openingId],
               openingWrapper.id == selection {
                addOpening(path: &path, opening: opening, xOffset: openingWrapper.xOffset, yOffset: openingWrapper.yOffset)
            }
        }
        for slot in box.slots[face]!.values {
            if slot.id == selection {
                addSlot(path: &path, slot: slot)
            }
        }
        return path
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
        
        let normal = sidePath(face: face, box: box, openings: openings)
        context.stroke(normal.applying(translation),
                       with: .color(Misc.normalColor),
                       lineWidth: Misc.lineWidth)
        
        let highlight = highlightPath(face: face, box: box, openings: openings, selection: selection)
        context.stroke(highlight.applying(translation),
                       with: .color(Misc.highlightColor),
                       lineWidth: Misc.lineWidth)
    }
    
    static func drawStock(context: GraphicsContext, size: CGSize, box: BoxModel, openings: Openings, selection: String?) {
        guard box.stockLength > 0, box.stockWidth > 0 else {
            return
        }
        let scale = min(size.width / box.stockWidth, size.height / box.stockLength)
        let offsetX = (size.width - box.stockWidth * scale) / 2
        let offsetY = (size.height - box.stockLength * scale) / 2
        let translation = CGAffineTransform(translationX: offsetX, y: offsetY)
            .scaledBy(x: scale, y: scale)

        var normalPath = Path()
        normalPath.addRect(CGRect(x: 0, y: 0, width: box.stockWidth, height: box.stockLength))
        if let selection = selection {
            if box.stockLayouts[selection] != nil {
                for stockFace in box.stockLayouts[selection]!.stockFaces.values {
                    let faceSize = box.size(face: stockFace.face)
                    
                    var faceTranslation = CGAffineTransform(translationX: stockFace.offsetX, y: stockFace.offsetY)
                    if stockFace.rotated {
                        faceTranslation = faceTranslation
                            .rotated(by: Double.pi / 2)
                            .translatedBy(x: 0, y: -faceSize.height)
                    }
                    let facePath = sidePath(face: stockFace.face, box: box, openings: openings).applying(faceTranslation)
                    normalPath.addPath(facePath)
                }
                context.stroke(normalPath.applying(translation),
                               with: .color(Misc.normalColor),
                               lineWidth: Misc.lineWidth)
                    
            } else if let stockLayoutId = box.getStockLayoutId(id: selection) {
                var highlightPath = Path()
                for stockFace in box.stockLayouts[stockLayoutId]!.stockFaces.values {
                    let faceSize = box.size(face: stockFace.face)
                    
                    var faceTranslation = CGAffineTransform(translationX: stockFace.offsetX, y: stockFace.offsetY)
                    if stockFace.rotated {
                        faceTranslation = faceTranslation
                            .rotated(by: Double.pi / 2)
                            .translatedBy(x: 0, y: -faceSize.height)
                    }
                    let facePath = sidePath(face: stockFace.face, box: box, openings: openings).applying(faceTranslation)
                    if stockFace.id == selection {
                        highlightPath.addPath(facePath)
                    } else {
                        normalPath.addPath(facePath)
                    }
                }
                context.stroke(normalPath.applying(translation),
                               with: .color(Misc.normalColor),
                               lineWidth: Misc.lineWidth)
                context.stroke(highlightPath.applying(translation),
                               with: .color(Misc.highlightColor),
                               lineWidth: Misc.lineWidth)
            }
                
        }
    }
}

//
//  StockDetailView.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/15/22.
//

import SwiftUI

struct StockDetailView: View {
    
    @Binding var document: BoxDesignDocument
    @Binding var selection: String?

    var body: some View {
        VStack {
            Canvas { context, size in
                 // Drawing.drawSide(context: context, size: size, face: face, box: document.data, openings: openings, selection: selection)
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: Misc.cornerRadius)
                    .stroke(Misc.highlightColor, lineWidth: Misc.lineWidth))
            .padding()

            if let selection = selection {
//                if document.data.stockLayouts[selection] != nil {
//                    Divider()
//                    FaceOpeningsOpeningDetail(document: $document,
//                                              selection: selection,
//                                              face: face)
//                } else if document.data.slots[face]![selection] != nil {
//                    Divider()
//                    FaceOpeningsSlotDetail(document: $document,
//                                           selection: selection,
//                                           face: face)
//                }
            }
        }
    }
}

struct StockDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StockDetailView(document: .constant(BoxDesignDocument()), selection: .constant(nil))
    }
}

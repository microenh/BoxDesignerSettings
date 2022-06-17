//
//  StockDetailView.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/15/22.
//

import SwiftUI

struct StockDetailView: View {
    
    @EnvironmentObject var openings: Openings
    @Binding var document: BoxDesignDocument
    @Binding var selection: String?

    var body: some View {
        VStack {
            if let selection = selection {
                Canvas { context, size in
                    Drawing.drawStock(context: context, size: size, box: document.data, openings: openings, selection: selection)
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: Misc.cornerRadius)
                        .stroke(Misc.highlightColor, lineWidth: Misc.lineWidth))
                .padding()
                
                if document.data.stockLayouts[selection] != nil {
                    StockLayoutView(document: $document, selection: selection)
                } else if let stockLayoutId = document.data.getStockLayoutId(id: selection) {
                    StockFaceView(document: $document, stockLayoutId: stockLayoutId, stockFaceId: selection)
                }
            } else {
                Text("Please Select")
            }
        }
    }
}

struct StockDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StockDetailView(document: .constant(BoxDesignDocument()), selection: .constant(nil))
    }
}

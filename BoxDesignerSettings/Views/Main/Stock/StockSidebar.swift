//
//  StockSidebar.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/15/22.
//

import SwiftUI

struct StockSidebar: View {
    
    @Binding var document: BoxDesignDocument
    @Binding var selection: String?
    @State private var expanded = ExpansionState()

    var body: some View {
       VStack {
           List(lineItems, selection: $selection) { master in
               HStack {
                   if master.master {
                       Button {
                           expanded[master.id].toggle()
                       } label: {
                           Image(systemName: expanded.contains(master.id)
                                 ? SystemImageNames.disclosureOpen
                                 : SystemImageNames.disclosureClosed)
                       }
                       .buttonStyle(BorderlessButtonStyle())
                   }
                   Image(systemName: master.master ? SystemImageNames.stockLayout: SystemImageNames.stockFace)
                       .padding(.leading, master.master ? 0.0 : Misc.disclosureDetailIndent)
                   Text(master.description)
               }
           }
           HStack {
               Button {
                   selection = document.data.addStockLayout()
               } label: {
                   Image(systemName: SystemImageNames.addItem)
                   Image(systemName: SystemImageNames.stockLayout)
               }
               Button {
                   selection = document.data.addStockFace(id: document.data.getStockLayoutId(id: selection))
               } label: {
                   Image(systemName: SystemImageNames.addItem)
                   Image(systemName: SystemImageNames.stockFace)
               }
           }
           .padding(.bottom)
       }
   }

   private struct Line: Identifiable {
       let id: String
       let master: Bool
       let description: String
   }
   
   private var lineItems: [Line] {
       var result = [Line]()
       for item in document.data.stockLayouts.values {
           result.append(Line(id: item.id, master: true, description: "Stock"))
           if expanded.contains(item.id) {
               for detailItem in item.stockFaces.values {
                   result.append(Line(id: detailItem.id, master: false, description: detailItem.face.rawValue))
               }
           }
       }
       return result
   }
}

struct StockSidebar_Previews: PreviewProvider {
    static var previews: some View {
        StockSidebar(document: .constant(BoxDesignDocument()), selection: .constant(nil))
    }
}

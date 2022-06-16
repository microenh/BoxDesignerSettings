//
//  StockLayoutView.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/15/22.
//

import SwiftUI

struct StockLayoutView: View {
    
    @Binding var document: BoxDesignDocument
    let selection: String?
    @State private var showModal = false
    @State private var delete = false


    var body: some View {
        VStack {
            // Spacer()
            Button {
                showModal = true
            } label: {
                Image(systemName: SystemImageNames.deleteItem)
            }
        }
        .padding()
        .navigationTitle("Stock Layout")
        .sheet(isPresented: $showModal) {
            if delete {
                document.data.deleteStockLayout(selection: selection)
            }
        } content: {
            DeletePrompt(message: "Delete Stock?", delete: $delete)
        }
    }
}

struct StockLayoutView_Previews: PreviewProvider {
    static var previews: some View {
        StockLayoutView(document: .constant(BoxDesignDocument()), selection: nil)
    }
}

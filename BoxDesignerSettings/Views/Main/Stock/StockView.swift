//
//  StockView.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/15/22.
//

import SwiftUI

struct StockView: View {
    
    @Binding var document: BoxDesignDocument
    @State private var selection: String?

    var body: some View {
        NavigationView {
            StockSidebar(document: $document, selection: $selection)
            StockDetailView(document: $document, selection: $selection)
        }
    }
}

struct StockView_Previews: PreviewProvider {
    static var previews: some View {
        StockView(document: .constant(BoxDesignDocument()))
    }
}

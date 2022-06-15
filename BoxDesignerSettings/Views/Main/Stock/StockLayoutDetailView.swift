//
//  StockLayoutDetailView.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/15/22.
//

import SwiftUI

struct StockLayoutDetailView: View {
    
    @Binding var document: BoxDesignDocument
    let selection: String?

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct StockLayoutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StockLayoutDetailView(document: .constant(BoxDesignDocument()), selection: nil)
    }
}

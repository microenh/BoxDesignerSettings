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

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct StockLayoutView_Previews: PreviewProvider {
    static var previews: some View {
        StockLayoutView(document: .constant(BoxDesignDocument()), selection: nil)
    }
}

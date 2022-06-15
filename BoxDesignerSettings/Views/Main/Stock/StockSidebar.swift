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

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct StockSidebar_Previews: PreviewProvider {
    static var previews: some View {
        StockSidebar(document: .constant(BoxDesignDocument()), selection: .constant(nil))
    }
}

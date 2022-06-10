//
//  SideView.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/9/22.
//

import SwiftUI

struct SideOpeningsView: View {
    
    @State private var selection: String?
    
    var body: some View {
        NavigationView {
            SideOpeningsSidebar(selection: $selection)
            
        }
    }
}

struct SideView_Previews: PreviewProvider {
    static var previews: some View {
        SideOpeningsView()
    }
}

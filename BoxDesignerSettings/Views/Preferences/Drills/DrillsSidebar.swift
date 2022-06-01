//
//  DrillsSidebar.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 5/31/22.
//

import SwiftUI

struct DrillsSidebar: View {
    
    @EnvironmentObject var materials: Materials
    @Binding var selection: Material.ID?
    
    var body: some View {
        VStack {
            List(selection: $selection) {
                ForEach([Material](materials.materials.values).sorted { $0.name < $1.name }) { material in
                    Text(material.name)
                }
             }
         }
    }
}


struct DrillsSidebar_Previews: PreviewProvider {
    static var previews: some View {
        DrillsSidebar(selection: .constant(nil))
            .environmentObject(Materials())
    }
}

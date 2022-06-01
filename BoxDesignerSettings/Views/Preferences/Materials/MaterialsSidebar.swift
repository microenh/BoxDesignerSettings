//
//  MaterialsSidebar.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 5/28/22.
//

import SwiftUI

struct MaterialsSidebar: View {
    
    @EnvironmentObject var materials: Materials
    @Binding var selection: Material.ID?
    
    var body: some View {
        VStack {
            List(selection: $selection) {
                ForEach([Material](materials.materials.values).sorted { $0.name < $1.name }) { material in
                    Text(material.name)
                }
            }
            Button {
                selection = materials.addNew()
            } label: {
                Image(systemName: "plus")
            }
            .padding(.bottom)
        }
        .listStyle(.sidebar)
    }
}

struct MaterialsSidebar_Previews: PreviewProvider {
    static var previews: some View {
        MaterialsSidebar(selection: .constant(nil))
            .environmentObject(Materials())
    }
}

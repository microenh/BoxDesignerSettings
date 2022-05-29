//
//  MaterialsSidebar.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 5/28/22.
//

import SwiftUI

struct MaterialsSidebar: View {
    
    @EnvironmentObject var materials: Materials
    @State private var selectedMaterialID: Material.ID?
    
    var body: some View {
        VStack {
            List(materials.materials) { material in
                NavigationLink(
                    destination: MaterialDetail(material: Binding(material)),
                    tag: material,
                    selection: $selectedMaterial,
                    label: {
                        HStack {
                            Image(systemName: "folder")
                            Text(material.name)
                        }
                    }
                )
            }
            Button {
                materials.addNew()
            } label: {
                Image(systemName: "plus")
            }
            .padding(.bottom)
        }
        .listStyle(.sidebar)
    }

    private var selection: Binding<Material.ID?> {
        Binding(get: { selectedMaterialID }, set: { selectedMaterialID = $0 })
    }
    
    private var selectedMaterial: Binding<Material> {
        $materials[selection.wrappedValue]
    }
}

struct MaterialsSidebar_Previews: PreviewProvider {
    static var previews: some View {
        MaterialsSidebar()
    }
}

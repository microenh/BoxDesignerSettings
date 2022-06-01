//
//  MaterialsView.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 5/28/22.
//

import SwiftUI

struct MaterialsView: View {
    @EnvironmentObject var materials: Materials
    @AppStorage("materialsMaterialID") private var selectedMaterialID: Material.ID?
    
    var body: some View {
        NavigationView {
            MaterialsSidebar(selection: selection)
            MaterialDetail(material: selectedMaterial)
        }
    }
    
    private var selection: Binding<Material.ID?> {
        Binding(get: { selectedMaterialID },
                set: { selectedMaterialID = $0 })
    }
    
    private var selectedMaterial: Binding<Material?> {
        $materials[selection.wrappedValue]
    }

}

struct MaterialsView_Previews: PreviewProvider {
    static var previews: some View {
        MaterialsView()
            .environmentObject(Materials())
    }
}

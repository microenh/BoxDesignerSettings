//
//  DrillsView.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 5/31/22.
//

import SwiftUI

struct DrillsView: View {
    @EnvironmentObject var materials: Materials
    @AppStorage("selectedMaterial") private var selectedMaterialID: Material.ID?
    @AppStorage("selectedDrill") private var selectedDrillID: Drill.ID?

    var body: some View {
        NavigationView {
            DrillsSidebar(selection: materialSelection)
            DrillList(materialSelection: selectedMaterialID,
                      drillSelection: drillSelection)
            DrillDetail(material: selectedMaterial, drillSelection: selectedDrillID)
        }
        .frame(minWidth: 100)
        .listStyle(.sidebar)
    }
    
    private var materialSelection: Binding<Material.ID?> {
        Binding(get: { selectedMaterialID },
                set: { selectedMaterialID = $0 })
    }
    
    private var drillSelection: Binding<Drill.ID?> {
        Binding(get: { selectedDrillID },
                set: { selectedDrillID = $0 })
    }
    
    private var selectedMaterial: Binding<Material?> {
        $materials[materialSelection.wrappedValue]
    }

}

struct DrillsView_Previews: PreviewProvider {
    static var previews: some View {
        DrillsView()
            .environmentObject(Materials())
    }
}

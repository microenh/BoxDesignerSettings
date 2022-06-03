//
//  DrillsDisclosureView.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/2/22.
//

import SwiftUI

struct DrillsView: View {
    @EnvironmentObject var materials: Materials
    @AppStorage("disclosureSelection") private var selection: String?
    @State private var materialSelection: String?

    var body: some View {
        NavigationView {
            DrillsSidebar(selection: $selection, materialSelection: $materialSelection)
            if let selection = selection {
                if selection.starts(with: "M") {
                    MaterialDetail(material: selectedMaterial)
                } else {
                    DrillDetail(material: selectedMaterial, drillSelection: selection)
                }
            }
        }
    }
    
    private var selectedMaterial: Binding<Material?> {
        if materialSelection == nil {
            return $materials[materials.getMaterialID(id: selection)]
        }
        return $materials[materialSelection]
    }
}

struct DrillsDisclosureView_Previews: PreviewProvider {
    static var previews: some View {
        DrillsView()
            .environmentObject(Materials())
    }
}

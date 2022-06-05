//
//  MaterialsView.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/2/22.
//

import SwiftUI

struct MaterialsView: View {
    @EnvironmentObject var preferences: Preferences
    @AppStorage("materialsSelection") private var selection: String?

    var body: some View {
        NavigationView {
            MaterialsSidebar(selection: $selection)
            if let selection = selection {
                if preferences.materials.items[selection] == nil {
                    DrillDetail(item: selectedItem, selection: selection)
                } else {
                    MaterialDetail(item: selectedItem)
                }
            }
        }
    }
    
    private var selectedItem: Binding<Materials.Item?> {
        return $preferences.materials[preferences.materials.getMasterId(id: selection)]
    }
}

struct MaterialsView_Previews: PreviewProvider {
    static var previews: some View {
        MaterialsView()
            .environmentObject(Preferences())
    }
}

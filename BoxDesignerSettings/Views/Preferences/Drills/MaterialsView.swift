//
//  DrillsDisclosureView.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/2/22.
//

import SwiftUI

struct MaterialsView: View {
    typealias Items = Materials
    
    @EnvironmentObject var items: Items
    @AppStorage("drillsSelection") private var selection: String?

    var body: some View {
        NavigationView {
            MaterialsSidebar(selection: $selection)
            if let selection = selection {
                if items.items[selection] == nil {
                    DrillDetail(item: selectedItem, selection: selection)
                } else {
                    MaterialDetail(item: selectedItem)
                }
            }
        }
    }
    
    private var selectedItem: Binding<Items.Item?> {
        return $items[items.getMasterId(id: selection)]
    }
}

struct DrillsDisclosureView_Previews: PreviewProvider {
    static var previews: some View {
        MaterialsView()
            .environmentObject(MaterialsView.Items())
    }
}

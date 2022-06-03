//
//  OpeningsView.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/1/22.
//

import SwiftUI

struct OpeningsView: View {
    typealias Items = Openings
    
    @EnvironmentObject var items: Items
    @AppStorage("openingsSelection") private var selection: String?
    
    var body: some View {
        NavigationView {
            OpeningsSidebar(selection: $selection)
            if let selection = selection {
                if items.items[selection] == nil {
                    HoleDetail(item: selectedDetailItem)
                } else {
                    OpeningDetail(item: selectedItem)
                }
             }
        }
    }
    
    private var selectedItem: Binding<Items.Item?> {
        return $items[items.getMasterId(id: selection)]
    }
    
    private var selectedDetailItem: Binding<Items.Item.DetailItem?> {
        if let selection = selection,
           let masterId = items.getMasterId(id: selection) {
            return Binding(get: { items[masterId]![selection]},
                           set: { items[masterId]![selection] = $0 })
        }
        return .constant(nil)
    }
}

struct OpeningsView_Previews: PreviewProvider {
    static var previews: some View {
        OpeningsView()
            .environmentObject(OpeningsView.Items())
    }
}

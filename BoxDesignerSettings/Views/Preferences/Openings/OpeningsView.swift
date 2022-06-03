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
    @State private var masterSelection: String?
    
    var body: some View {
        NavigationView {
            OpeningsSidebar(selection: $selection, masterSelection: $masterSelection)
            if let selection = selection {
                if selection.starts(with: "M") {
                    OpeningDetail(item: selectedItem)
                } else {
                    HoleDetail(opening: selectedItem, holeSelection: selection)
                }
            }
        }
    }
    
    private var selectedItem: Binding<Items.Item?> {
        if masterSelection == nil {
            return $items[items.getMasterId(id: selection)]
        }
        return $items[masterSelection]
    }
}

struct OpeningsView_Previews: PreviewProvider {
    typealias Items = Openings
    static var previews: some View {
        OpeningsView()
            .environmentObject(Items())
    }
}

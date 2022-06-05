//
//  OpeningsView.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/1/22.
//

import SwiftUI

struct OpeningsView: View {
    @EnvironmentObject var preferences: Preferences
    @AppStorage("openingsSelection") private var selection: String?
    
    var body: some View {
        NavigationView {
            OpeningsSidebar(selection: $selection)
            if let selection = selection {
                if preferences.openings.items[selection] == nil {
                    SlotDetail(item: selectedItem, selection: selection)
                } else {
                    OpeningDetail(item: selectedItem)
                }
             }
        }
    }
    
    private var selectedItem: Binding<Openings.Item?> {
        return $preferences.openings[preferences.openings.getMasterId(id: selection)]
    }
}

struct OpeningsView_Previews: PreviewProvider {
    static var previews: some View {
        OpeningsView()
            .environmentObject(Preferences())
    }
}

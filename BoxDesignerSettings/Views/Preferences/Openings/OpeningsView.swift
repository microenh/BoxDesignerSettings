//
//  OpeningsView.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/1/22.
//

import SwiftUI

struct OpeningsView: View {
    @EnvironmentObject var openings: Openings
    @AppStorage("openingsOpeningID") private var selectedOpeningID: Opening.ID?
    
    var body: some View {
        NavigationView {
            OpeningsSidebar(selection: selection)
            OpeningsDetail(opening: selectedOpening)
        }
    }
    
    private var selection: Binding<Opening.ID?> {
        Binding(get: { selectedOpeningID },
                set: { selectedOpeningID = $0 })
    }
    
    private var selectedOpening: Binding<Opening?> {
        $openings[selection.wrappedValue]
    }
}

struct OpeningsView_Previews: PreviewProvider {
    static var previews: some View {
        OpeningsView()
            .environmentObject(Openings())
    }
}

//
//  OpeningsView.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/1/22.
//

import SwiftUI

struct OpeningsView: View {
    @EnvironmentObject var openings: Openings
    @AppStorage("openingsSelection") private var selection: String?
    @State private var openingSelection: String?
    
    var body: some View {
        NavigationView {
            OpeningsSidebar(selection: $selection, openingSelection: $openingSelection)
            if let selection = selection {
                if selection.starts(with: "M") {
                    OpeningDetail(opening: selectedOpening)
                } else {
                    HoleDetail(opening: selectedOpening, holeSelection: selection)
                }
            }
        }
    }
    
    private var selectedOpening: Binding<Opening?> {
        if openingSelection == nil {
            return $openings[openings.getOpeningID(id: selection)]
        }
        return $openings[openingSelection]
    }
}

struct OpeningsView_Previews: PreviewProvider {
    static var previews: some View {
        OpeningsView()
            .environmentObject(Openings())
    }
}

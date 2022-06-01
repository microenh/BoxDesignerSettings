//
//  HolesView.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/1/22.
//

import SwiftUI

struct HolesView: View {
    @EnvironmentObject var openings: Openings
    @AppStorage("selectedOpening") private var selectedOpeningID: Opening.ID?
    @AppStorage("selectedHole") private var selectedHoleID: Hole.ID?

    var body: some View {
        NavigationView {
            HolesSidebar(selection: openingSelection)
            HoleList(openingSelection: selectedOpeningID,
                      holeSelection: holeSelection)
            HoleDetail(opening: selectedOpening, holeSelection: selectedHoleID)
        }
        .frame(minWidth: 100)
        .listStyle(.sidebar)
    }
    
    private var openingSelection: Binding<Opening.ID?> {
        Binding(get: { selectedOpeningID },
                set: { selectedOpeningID = $0 })
    }
    
    private var holeSelection: Binding<Hole.ID?> {
        Binding(get: { selectedHoleID },
                set: { selectedHoleID = $0 })
    }
    
    private var selectedOpening: Binding<Opening?> {
        $openings[openingSelection.wrappedValue]
    }

}

struct HolesView_Previews: PreviewProvider {
    static var previews: some View {
        HolesView()
            .environmentObject(Openings())
    }
}

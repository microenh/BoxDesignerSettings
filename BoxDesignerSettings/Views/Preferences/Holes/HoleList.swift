//
//  HoleList.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/1/22.
//

import SwiftUI

struct HoleList: View {
    
    @EnvironmentObject var openings: Openings
    let openingSelection: Opening.ID?
    @Binding var holeSelection: Hole.ID?
    
    var body: some View {
        if openingSelection != nil,
           let opening = openings.openings[openingSelection!] {
            List(selection: $holeSelection) {
                ForEach([Hole](opening.holes.values).sorted { $0.type.description < $1.type.description }) { hole in
                    Text(hole.type.description)
                }
            }
            Button {
                holeSelection = openings.addNewHole(openingID: openingSelection)
            } label: {
                Image(systemName: "plus")
            }
            .padding(.bottom)
            
        }
    }
}

struct HoleList_Previews: PreviewProvider {
    static var previews: some View {
        HoleList(openingSelection: nil, holeSelection: .constant(nil))
            .environmentObject(Openings())
    }
}

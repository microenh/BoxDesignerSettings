//
//  DrillList.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 5/31/22.
//

import SwiftUI

struct DrillList: View {
    
    @EnvironmentObject var materials: Materials
    let materialSelection: Material.ID?
    @Binding var drillSelection: Drill.ID?
    
    var body: some View {
        if materialSelection != nil,
           let material = materials.materials[materialSelection!] {
            List(selection: $drillSelection) {
                ForEach([Drill](material.drills.values).sorted { $0.type < $1.type }) { drill in
                    Text(drill.type)
                }
            }
            Button {
                drillSelection = materials.addNewDrill(materialID: materialSelection)
            } label: {
                Image(systemName: "plus")
            }
            .padding(.bottom)

        }
    }
}

struct DrillList_Previews: PreviewProvider {
    static var previews: some View {
        DrillList(materialSelection: nil, drillSelection: .constant(nil))
            .environmentObject(Materials())
    }
}

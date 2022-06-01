//
//  DrillDetail.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 5/31/22.
//

import SwiftUI

struct DrillDetail: View {
    @EnvironmentObject var materials: Materials
    @Binding var material: Material?
    let drillSelection: Drill.ID?
    @State private var showModal = false
    @State private var delete = false

    
    var body: some View {
        if material != nil,
           let drillSelection = drillSelection,
           material!.drills[drillSelection] != nil {
            VStack {
                TextField("Type",
                          text: Binding(get: { material!.drills[drillSelection]!.type },
                                        set: { material!.drills[drillSelection]!.type = $0 }))
                Spacer()
                Button {
                    showModal = true
                } label: {
                    Image(systemName: "minus")
                }
            }
            .padding()
            .navigationTitle(material!.drills[drillSelection]!.type)
            .sheet(isPresented: $showModal) {
                if delete {
                    materials.removeDrill(materialID: material!.id, drillID: drillSelection)
                }
            } content: {
                DeletePrompt(message: "Delete \(material!.drills[drillSelection]!.type)?", delete: $delete)
            }
            
        }
    }
}

struct DrillDetail_Previews: PreviewProvider {
    static var previews: some View {
        DrillDetail(material: .constant(Material()), drillSelection: nil)
            .environmentObject(Materials())
    }
}

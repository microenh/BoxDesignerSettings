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
                ScrollView(.vertical) {
                    Form {
                        TextField("Type", text: drill.type)
                        TextField("Diameter", value: drill.diameter, format: .number)
                        TextField("Flutes", value: drill.flutes, format: .number)
                        TextField("min Load", value: drill.minChipLoad, format: .number)
                        TextField("max Load", value: drill.maxChipLoad, format: .number)
                        TextField("Flutes", value: drill.flutes, format: .number)
                        TextField("V Speed", value: drill.verticalSpeed, format: .number)
                        TextField("Pass Depth", value: drill.depthPerPass, format: .number)
                        Toggle(isOn: drill.conventional) {
                            Text("Conventional")
                        }
                    }
                }
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
    
    private var drill: Binding<Drill> {
        Binding(get: { material!.drills[drillSelection!]! },
                set: { material!.drills[drillSelection!]! = $0 })
    }
    

}

struct DrillDetail_Previews: PreviewProvider {
    static var previews: some View {
        DrillDetail(material: .constant(Material()), drillSelection: nil)
            .environmentObject(Materials())
    }
}

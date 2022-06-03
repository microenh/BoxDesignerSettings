//
//  DrillsDisclosureSidebar.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/2/22.
//

import SwiftUI

struct DrillsSidebar: View {
    @EnvironmentObject var materials: Materials
    @Binding var selection: String?
    @Binding var materialSelection: String?
    @AppStorage("drillExpanded") private var expanded = ExpansionState()
    
    private static let detailIndent = CGFloat(20)

    var body: some View {
        VStack {
            List(items, selection: $selection) { master in
                HStack {
                    if master.master {
                        Button {
                            expanded[master.id].toggle()
                        } label: {
                            Image(systemName: expanded.contains(master.id)
                                  ? "arrowtriangle.down"
                                  : "arrowtriangle.forward")
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                    Text(master.name)
                        .padding(.leading, master.master ? 0.0 : Self.detailIndent)
                }
            }
            .onChange(of: selection) { newValue in
                materialSelection = materials.getMaterialID(id: selection)
            }
            HStack {
                Button {
                    selection = materials.addNew()
                } label: {
                    Image(systemName: "plus")
                    Image(systemName: "square.3.layers.3d.down.right")
                }
                Button {
                    selection = materials.addNewDrill(materialID: materialSelection)
                } label: {
                    Image(systemName: "plus")
                    Image(systemName: "hurricane")
                }
            }
            .padding(.bottom)
        }
        .frame(width: 200)
    }
    
    struct Line: Identifiable {
        let id: String
        let master: Bool
        let name: String
    }
    
    private var items: [Line] {
        var result = [Line]()
        for material in materials.materials.values {
            result.append(Line(id: material.id, master: true, name: material.name))
            if expanded.contains(material.id) {
                for drill in material.drills.values {
                    result.append(Line(id: drill.id, master: false, name: drill.name))
                }
                
            }
        }
        return result
    }
}

struct DrillsDisclosureSidebar_Previews: PreviewProvider {
    static var previews: some View {
        DrillsSidebar(selection: .constant(nil),
                                materialSelection: .constant(nil))
            .environmentObject(Materials())
    }
}

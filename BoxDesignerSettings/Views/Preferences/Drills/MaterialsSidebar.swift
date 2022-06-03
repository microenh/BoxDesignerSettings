//
//  DrillsDisclosureSidebar.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/2/22.
//

import SwiftUI

struct MaterialsSidebar: View {
    typealias Items = MaterialsView.Items
    
    @EnvironmentObject var items: Items
    @Binding var selection: String?
    @AppStorage("drillExpanded") private var expanded = ExpansionState()
    
    var body: some View {
        VStack {
            List(lineItems, selection: $selection) { master in
                HStack {
                    if master.master {
                        Button {
                            expanded[master.id].toggle()
                        } label: {
                            Image(systemName: expanded.contains(master.id)
                                  ? SystemImageNames.disclosureOpen
                                  : SystemImageNames.disclosureClosed)
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                    Text(master.name)
                        .padding(.leading, master.master ? 0.0 : Misc.disclosureDetailIndent)
                }
            }
            HStack {
                Button {
                    selection = items.addNew()
                } label: {
                    Image(systemName: SystemImageNames.addItem)
                    Image(systemName: SystemImageNames.materials)
                }
                Button {
                    selection = items.addNewDetail(id: items.getMasterId(id: selection))
                } label: {
                    Image(systemName: SystemImageNames.addItem)
                    Image(systemName: SystemImageNames.drills)
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
    
    private var lineItems: [Line] {
        var result = [Line]()
        for item in items.items.values {
            result.append(Line(id: item.id, master: true, name: item.name))
            if expanded.contains(item.id) {
                for drill in item.detailItems.values {
                    result.append(Line(id: drill.id, master: false, name: drill.name))
                }
            }
        }
        return result
    }
}

struct DrillsDisclosureSidebar_Previews: PreviewProvider {
    static var previews: some View {
        MaterialsSidebar(selection: .constant(nil))
            .environmentObject(MaterialsSidebar.Items())
    }
}

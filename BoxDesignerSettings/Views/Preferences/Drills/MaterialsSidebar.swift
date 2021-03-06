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
                    Image(systemName: master.master ? SystemImageNames.materials: SystemImageNames.drills)
                        .padding(.leading, master.master ? 0.0 : Misc.disclosureDetailIndent)
                    Text(master.description)
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
//                    Image(systemName: SystemImageNames.addItem)
//                    Image(systemName: SystemImageNames.drills)
                    Image("drill.plus")
                }
            }
            .padding(.bottom)
        }
        .frame(width: 200)
    }
    
    private struct Line: Identifiable {
        let id: String
        let master: Bool
        let description: String
    }
    
    private var lineItems: [Line] {
        var result = [Line]()
        for item in items.items.values.sorted(by: { $0.description < $1.description }) {
            result.append(Line(id: item.id, master: true, description: item.description))
            if expanded.contains(item.id) {
                for detailItem in item.detailItems.values.sorted(by: { $0.description < $1.description }) {
                    result.append(Line(id: detailItem.id, master: false, description: detailItem.description))
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

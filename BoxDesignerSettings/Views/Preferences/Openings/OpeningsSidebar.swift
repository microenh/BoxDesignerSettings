//
//  OpeningsSidebar.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/1/22.
//

import SwiftUI

struct OpeningsSidebar: View {
    typealias Items = Openings
    
    @EnvironmentObject var items: Items
    @Binding var selection: String?
    @AppStorage("openingExpanded") private var expanded = ExpansionState()
    
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
                    Image(systemName: master.master ? SystemImageNames.openings: SystemImageNames.slots)
                        .padding(.leading, master.master ? 0.0 : Misc.disclosureDetailIndent)
                    Text(master.description)
                }
            }
            HStack {
                Button {
                    selection = items.addNew()
                } label: {
                    Image(systemName: SystemImageNames.addItem)
                    Image(systemName: SystemImageNames.openings)
                }
                Button {
                    selection = items.addDetail(id: items.getMasterId(id: selection))
                } label: {
                    Image(systemName: SystemImageNames.addItem)
                    Image(systemName: SystemImageNames.slots)
                }
            }
            .padding(.bottom)
        }
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

struct OpeningsSidebar_Previews: PreviewProvider {
    static var previews: some View {
        OpeningsSidebar(selection: .constant(nil))
            .environmentObject(OpeningsSidebar.Items())
    }
}

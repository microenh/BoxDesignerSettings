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
                    Text(master.name)
                        .padding(.leading, master.master ? 0.0 : Misc.disclosureDetailIndent)
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
                    Image(systemName: SystemImageNames.holes)
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
                for detailItem in item.detailItems.values {
                    result.append(Line(id: detailItem.id, master: false, name: detailItem.type.description))
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

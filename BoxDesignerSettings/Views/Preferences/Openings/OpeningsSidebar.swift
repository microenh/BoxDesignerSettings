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
    @Binding var masterSelection: String?
    @AppStorage("openingExpanded") private var expanded = ExpansionState()
    
    private static let detailIndent = CGFloat(20)
    
    var body: some View {
        VStack {
            List(lineItems, selection: $selection) { master in
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
                masterSelection = items.getMasterId(id: selection)
            }
            HStack {
                Button {
                    selection = items.addNew()
                } label: {
                    Image(systemName: "plus")
                    Image(systemName: "square.grid.3x3")
                }
                Button {
                    selection = items.addDetail(id: items.getMasterId(id: selection))
                } label: {
                    Image(systemName: "plus")
                    Image(systemName: "square.grid.3x3.topleft.filled")
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
                for hole in item.detailItems.values {
                    result.append(Line(id: hole.id, master: false, name: hole.type.description))
                }
            }
        }
        return result
    }

}

struct OpeningsSidebar_Previews: PreviewProvider {
    typealias Items = Openings
    static var previews: some View {
        OpeningsSidebar(selection: .constant(nil), masterSelection: .constant(nil))
            .environmentObject(Openings())
    }
}

//
//  OpeningsSidebar.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/1/22.
//

import SwiftUI

struct OpeningsSidebar: View {
    
    @EnvironmentObject var openings: Openings
    @Binding var selection: String?
    @Binding var openingSelection: String?
    @AppStorage("openingExpanded") private var expanded = ExpansionState()
    
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
                openingSelection = openings.getOpeningID(id: selection)
            }
            HStack {
                Button {
                    selection = openings.addNew()
                } label: {
                    Image(systemName: "plus")
                    Image(systemName: "square.grid.3x3")
                }
                Button {
                    selection = openings.addNewHole(openingID: openingSelection)
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
    
    private var items: [Line] {
        var result = [Line]()
        for opening in openings.openings.values {
            result.append(Line(id: opening.id, master: true, name: opening.name))
            if expanded.contains(opening.id) {
                for hole in opening.holes.values {
                    result.append(Line(id: hole.id, master: false, name: hole.type.description))
                }
            }
        }
        return result
    }

}

struct OpeningsSidebar_Previews: PreviewProvider {
    static var previews: some View {
        OpeningsSidebar(selection: .constant(nil), openingSelection: .constant(nil))
            .environmentObject(Openings())
    }
}

//
//  OpeningsSidebar.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/1/22.
//

import SwiftUI

struct OpeningsSidebar: View {
    
    @EnvironmentObject var openings: Openings
    @Binding var selection: Opening.ID?
    
    var body: some View {
        VStack {
            List(selection: $selection) {
                ForEach([Opening](openings.openings.values).sorted { $0.name < $1.name }) { opening in
                    Text(opening.name)
                }
            }
            Button {
                selection = openings.addNew()
            } label: {
                Image(systemName: "plus")
            }
            .padding(.bottom)
        }
        .listStyle(.sidebar)
    }
}

struct OpeningsSidebar_Previews: PreviewProvider {
    static var previews: some View {
        OpeningsSidebar(selection: .constant(nil))
            .environmentObject(Openings())
    }
}

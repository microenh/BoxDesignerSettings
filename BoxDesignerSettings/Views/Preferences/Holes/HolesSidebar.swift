//
//  HolesSidebar.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/1/22.
//

import SwiftUI

struct HolesSidebar: View {
    
    @EnvironmentObject var openings: Openings
    @Binding var selection: Opening.ID?

    var body: some View {
        VStack {
            List(selection: $selection) {
                ForEach([Opening](openings.openings.values).sorted { $0.name < $1.name }) { opening in
                    Text(opening.name)
                }
            }
        }
    }
}

struct HolesSidebar_Previews: PreviewProvider {
    static var previews: some View {
        HolesSidebar(selection: .constant(nil))
            .environmentObject(Openings())
    }
}

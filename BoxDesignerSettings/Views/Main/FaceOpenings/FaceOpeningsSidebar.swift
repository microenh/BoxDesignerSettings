//
//  SideOpeningsSidebar.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/9/22.
//

import SwiftUI

struct FaceOpeningsSidebar: View {
    
    @EnvironmentObject var openings: Openings
    
    @Binding var document: BoxDesignDocument
    @Binding var selection: String?
     
    let face: Face
    
    var body: some View {
        VStack {
            List(selection: $selection) {
                ForEach(Array(document.data.openings[face]!.values)) { opening in
                    HStack {
                        Image(systemName: SystemImageNames.openings)
                        if let openingId = opening.openingId,
                           openings.items[openingId] != nil {
                            Text(openings.items[openingId]!.name)
                        } else {
                            Text("new")
                        }
                    }
                }
                if document.data.openings[face]!.values.count > 0
                    && document.data.slots[face]!.values.count > 0 {
                    Divider()
                }
                ForEach(Array(document.data.slots[face]!.values)) { slot in
                    HStack {
                        Image(systemName: SystemImageNames.slots)
                        Text(slot.description)
                    }
                }
            }
        }
        Spacer()
        HStack {
            Button {
                selection = document.data.addOpening(face: face)
            } label: {
                Image(systemName: SystemImageNames.addItem)
                Image(systemName: SystemImageNames.openings)
            }
            Button {
                selection = document.data.addSlot(face: face)
            } label: {
                Image(systemName: SystemImageNames.addItem)
                Image(systemName: SystemImageNames.slots)
            }
        }
        .padding(.bottom)
    }
}

struct FaceOpeningsSidebar_Previews: PreviewProvider {
    static var previews: some View {
        FaceOpeningsSidebar(document: .constant(BoxDesignDocument()),
                            selection: .constant(nil),
                            face: .front)
    }
}

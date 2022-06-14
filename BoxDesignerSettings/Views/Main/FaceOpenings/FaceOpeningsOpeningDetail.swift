//
//  SideOpeningsOpeningDetail.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/9/22.
//

import SwiftUI

struct FaceOpeningsOpeningDetail: View {
    
    @EnvironmentObject var openings: Openings
    @Binding var document: BoxDesignDocument
    
    let selection: String?
    let face: Face
    
    @State private var showModal = false
    @State private var delete = false

    var body: some View {
        if let selection = selection {
            VStack {
                Text("\(face.rawValue) Opening Detail")
                Spacer()
                
                Picker("Opening", selection: binding.openingId) {
                    ForEach(Array(openings.items.values)) { value in
                        HStack {
                            Text(value.name)
                        }.tag(value.id)
                    }
                }
                
                ScrollView(.vertical) {
                    Form {
                        TextField("X offest (mm)", value: binding.xOffset, format: .number)
                        TextField("Y offset(mm)", value: binding.yOffset, format: .number)
                    }
                }

                Button {
                    showModal = true
                } label: {
                    Image(systemName: SystemImageNames.deleteItem)
                }
            }
            .padding()
            .sheet(isPresented: $showModal) {
                if delete {
                    document.data.deleteOpening(face: face, selection: selection)
                }
            } content: {
                DeletePrompt(message: "Delete Opening?", delete: $delete)
            }
        }
    }
    
    private var binding: Binding<OpeningWrapper> {
        Binding(get: { document.data.openings[face]![selection!]! },
                set: { document.data.openings[face]![selection!]! = $0 })
    }

}

struct FaceOpeningsOpeningDetail_Previews: PreviewProvider {
    static var previews: some View {
        FaceOpeningsOpeningDetail(document: .constant(BoxDesignDocument()),
                                  selection: nil,
                                  face: .front)
        .environmentObject(Openings())
    }
}

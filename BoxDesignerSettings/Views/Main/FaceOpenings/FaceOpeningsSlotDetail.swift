//
//  FAceOpeningsSlotDetail.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/9/22.
//

import SwiftUI

struct FaceOpeningsSlotDetail: View {
    
    @Binding var document: BoxDesignDocument
    
    let selection: String?
    let face: Face
    
    @State private var showModal = false
    @State private var delete = false

    var body: some View {
        if let selection = selection {
            VStack {
                Text("\(face.rawValue) Slot Detail")
                
                Picker("Shape", selection: binding.type) {
                    ForEach(SlotType.allCases, id: \.self) { value in
                        HStack {
                            Text(value.rawValue)
                        }.tag(value)
                    }
                 }
                ScrollView(.vertical) {
                    Form {
                        switch binding.type.wrappedValue {
                        case .circle:
                            TextField("Diameter (mm)", value: binding.dimension1, format: .number)
                        case .square:
                            TextField("Side (mm)", value: binding.dimension1, format: .number)
                        case .ellipse, .rectangle, .capsule:
                            TextField("Width (mm)", value: binding.dimension1, format: .number)
                            TextField("Height (mm)", value: binding.dimension2, format: .number)
                        }
                        TextField("X Offset (mm)", value: binding.xOffset, format: .number)
                        TextField("Y Offset (mm)", value: binding.yOffset, format: .number)
                    }
                }
                Spacer()
                Button {
                    showModal = true
                } label: {
                    Image(systemName: SystemImageNames.deleteItem)
                }
            }
            .padding()
            .sheet(isPresented: $showModal) {
                if delete {
                    document.data.deleteSlot(face: face, selection: selection)
                }
            } content: {
                DeletePrompt(message: "Delete Slot?", delete: $delete)
            }
        }
    }
    
    private var binding: Binding<Slot> {
        Binding(get: { document.data.slots[face]![selection!]! },
                set: { document.data.slots[face]![selection!]! = $0 })
    }
}

struct FaceOpeningsSlotDetail_Previews: PreviewProvider {
    static var previews: some View {
        FaceOpeningsSlotDetail(document: .constant(BoxDesignDocument()),
                               selection: nil,
                               face: .front)
    }
}

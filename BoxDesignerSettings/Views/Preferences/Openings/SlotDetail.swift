//
//  HoleDetail.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/1/22.
//

import SwiftUI

struct SlotDetail: View {
    typealias Items = OpeningsView.Items
    
    @EnvironmentObject var items: Items
    @Binding var item: Items.Item?
    let selection: String?
    @State private var showModal = false
    @State private var delete = false
    
    // @State var slotType: SlotType = .circle
    
    var body: some View {
        if item != nil,
           let selection = selection,
           item!.detailItems[selection] != nil {
            VStack {
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
                            TextField("Diameter", value: binding.dimension1, format: .number)
                        case .square:
                            TextField("Side", value: binding.dimension1, format: .number)
                        case .ellipse, .rectangle, .capsule:
                            TextField("Width", value: binding.dimension1, format: .number)
                            TextField("Height", value: binding.dimension2, format: .number)
                        }
                        TextField("X Offset", value: binding.xCenter, format: .number)
                        TextField("Y Offset", value: binding.yCenter, format: .number)
                        TextField("Rotation", value: binding.rotation, format: .number)
                    }
                }
                Spacer()
                Button {
                    showModal = true
                } label: {
                    Image(systemName: SystemImageNames.deleteItem)
                    Image(systemName: SystemImageNames.slots)
                }
            }
            .padding()
            .sheet(isPresented: $showModal) {
                if delete {
                    items.removeDetail(id: selection)
                }
            } content: {
                DeletePrompt(message: "Delete \(binding.wrappedValue.description)?", delete: $delete)
            }
        }
    }
    
    private var binding: Binding<Items.Item.DetailItem> {
        Binding(get: { item!.detailItems[selection!]! },
                set: { item!.detailItems[selection!]! = $0 })
    }
}

struct HoleDetail_Previews: PreviewProvider {
    static var previews: some View {
        SlotDetail(item: .constant(SlotDetail.Items.Item()), selection: nil)
            .environmentObject(SlotDetail.Items())
    }
}
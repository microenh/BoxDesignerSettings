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
                Canvas { context, size in
                    Drawing.drawOpening(context: context, size: size, item: item!, selection: selection)
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: Misc.cornerRadius)
                        .stroke(Misc.highlightColor, lineWidth: Misc.lineWidth))
                .padding()
                Divider()
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
                    // Image(systemName: SystemImageNames.slots)
                }
            }
            .frame(width: Misc.inputFormWidth)
            .navigationTitle("Slot")
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

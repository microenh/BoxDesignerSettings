//
//  DrillDetail.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 5/31/22.
//

import SwiftUI

struct DrillDetail: View {
    typealias Items = MaterialsView.Items
    
    @EnvironmentObject var items: Items
    @Binding var item: Items.Item?
    let selection: String?
    @State private var showModal = false
    @State private var delete = false

    var body: some View {
        if item != nil,
           let selection = selection,
           item!.detailItems[selection] != nil {
            VStack {
                ScrollView(.vertical) {
                    Form {
                        TextField("Type", text: binding.type)
                        TextField("Diameter", value: binding.diameter, format: .number)
                        TextField("Flutes", value: binding.flutes, format: .number)
                        TextField("min Load", value: binding.minChipLoad, format: .number)
                        TextField("max Load", value: binding.maxChipLoad, format: .number)
                        TextField("Flutes", value: binding.flutes, format: .number)
                        TextField("V Speed", value: binding.verticalSpeed, format: .number)
                        TextField("Pass Depth", value: binding.depthPerPass, format: .number)
                        Toggle(isOn: binding.conventional) {
                            Text("Conventional")
                        }
                    }
                }
                Spacer()
                Button {
                    showModal = true
                } label: {
                    Image(systemName: SystemImageNames.deleteItem)
                    Image(systemName: SystemImageNames.drills)
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

struct DrillDetail_Previews: PreviewProvider {
    static var previews: some View {
        DrillDetail(item: .constant(DrillDetail.Items.Item()), selection: nil)
            .environmentObject(DrillDetail.Items())
    }
}

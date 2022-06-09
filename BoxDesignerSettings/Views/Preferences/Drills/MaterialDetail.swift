//
//  MaterialDetail.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 5/28/22.
//

import SwiftUI

struct MaterialDetail: View {
    typealias Items = MaterialsView.Items

    @EnvironmentObject var items: Items
    @Binding var item: Items.Item?
    @State private var showModal = false
    @State private var delete = false

    var body: some View {
        if item != nil {
            VStack {
                ScrollView(.vertical) {
                    Form {
                        TextField("Name", text: binding.name)
                        Text("Chip Load Range")
                        
                        HStack {
                            TextField("1mm", value: binding.minChipLoad1mm, format: .number)
                            TextField(" - ", value: binding.maxChipLoad1mm, format: .number)
                        }
                        .frame(maxWidth: .infinity)
                        HStack {
                            TextField("3mm", value: binding.minChipLoad3mm, format: .number)
                            TextField(" - ", value: binding.maxChipLoad3mm, format: .number)
                        }
                        HStack {
                            TextField("6mm", value: binding.minChipLoad6mm, format: .number)
                            TextField(" - ", value: binding.maxChipLoad6mm, format: .number)
                        }
                        
                    }
                    .frame(width: Misc.inputFormWidth)
                }
                Spacer()
                Button {
                    showModal = true
                } label: {
                    Image(systemName: SystemImageNames.deleteItem)
                    // Image(systemName: SystemImageNames.materials)
                }
            }
            .padding()
            .navigationTitle("Material")
            .sheet(isPresented: $showModal) {
                if delete {
                    items.remove(item: item!)
                }
            } content: {
                DeletePrompt(message: "Delete \(binding.wrappedValue.description)?", delete: $delete)
            }
        }
    }
    
    private var binding: Binding<Items.Item> {
        Binding(get: { item! },
                set: { item! = $0 })
    }

}

struct MaterialDetail_Previews: PreviewProvider {
    static var previews: some View {
        MaterialDetail(item: .constant(MaterialDetail.Items.Item()))
            .environmentObject(MaterialDetail.Items())
    }
}

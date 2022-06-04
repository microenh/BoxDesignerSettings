//
//  HoleDetail.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/1/22.
//

import SwiftUI

struct HoleDetail: View {
    typealias Items = OpeningsView.Items
    
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
                Picker("Shape", selection: binding.type.rawValue) {
                    HStack {
                        Text("Circle")
                    }.tag(0)
                    HStack {
                        Text("Ellipse")
                    }.tag(1)
                    HStack {
                        Text("Square")
                    }.tag(2)
                    HStack {
                        Text("Rectangle")
                    }.tag(3)
                    HStack {
                        Text("Capsule")
                    }.tag(4)
                }
                ScrollView(.vertical) {
                    Form {
                        switch binding.type.rawValue.wrappedValue {
                        case 0:
                            TextField("Diameter", value: binding.xCenter, format: .number)
                        case 1:
                            TextField("Size (X)", value: binding.xCenter, format: .number)
                            TextField("Size (Y)", value: binding.xCenter, format: .number)
                        case 2:
                            TextField("Side", value: binding.xCenter, format: .number)
                        case 3:
                            TextField("Size (X)", value: binding.xCenter, format: .number)
                            TextField("Size (Y)", value: binding.xCenter, format: .number)
                        case 4:
                            TextField("Size (X)", value: binding.xCenter, format: .number)
                            TextField("Size (Y)", value: binding.xCenter, format: .number)
                        default:
                            EmptyView()
                        }
                        TextField("Center (X)", value: binding.xCenter, format: .number)
                        TextField("Center (Y)", value: binding.yCenter, format: .number)
                    }
                }
                Spacer()
                Button {
                    showModal = true
                } label: {
                    Image(systemName: SystemImageNames.deleteItem)
                    Image(systemName: SystemImageNames.holes)
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
        HoleDetail(item: .constant(HoleDetail.Items.Item()), selection: nil)
            .environmentObject(HoleDetail.Items())
    }
}

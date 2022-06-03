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
                        TextField("Name",
                                  text: Binding(get: {item!.name}, set: {item!.name = $0}))
                    }
                }
                Spacer()
                Button {
                    showModal = true
                } label: {
                    Image(systemName: SystemImageNames.deleteItem)
                    Image(systemName: SystemImageNames.materials)
                }
            }
            .padding()
            .sheet(isPresented: $showModal) {
                if delete {
                    items.remove(item: item!)
                }
            } content: {
                DeletePrompt(message: "Delete \(item!.name)?", delete: $delete)
            }
        }
    }
}


struct MaterialDetail_Previews: PreviewProvider {
    static var previews: some View {
        MaterialDetail(item: .constant(DrillDetail.Items.Item()))
            .environmentObject(DrillDetail.Items())
    }
}

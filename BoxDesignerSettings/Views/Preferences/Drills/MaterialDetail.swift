//
//  MaterialDetail.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 5/28/22.
//

import SwiftUI

struct MaterialDetail: View {

    @EnvironmentObject var model: Materials
    @Binding var item: Material?
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
                    Image(systemName: "minus")
                    Image(systemName: "square.3.layers.3d.down.right")
                }
            }
            .padding()
            .sheet(isPresented: $showModal) {
                if delete {
                    model.remove(material: item!)
                }
            } content: {
                DeletePrompt(message: "Delete \(item!.name)?", delete: $delete)
            }
        }
    }
}


struct MaterialDetail_Previews: PreviewProvider {
    static var previews: some View {
        MaterialDetail(item: .constant(Material()))
            .environmentObject(Materials())
    }
}

//
//  MaterialDetail.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 5/28/22.
//

import SwiftUI

struct MaterialDetail: View {

    @EnvironmentObject var materials: Materials
    @Binding var material: Material?
    @State private var showModal = false
    @State private var delete = false

    var body: some View {
        if material != nil {
            VStack {
                ScrollView(.vertical) {
                    Form {
                        TextField("Name",
                                  text: Binding(get: {material!.name}, set: {material!.name = $0}))
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
                    materials.remove(material: material!)
                }
            } content: {
                DeletePrompt(message: "Delete \(material!.name)?", delete: $delete)
            }
        }
    }
}


struct MaterialDetail_Previews: PreviewProvider {
    static var previews: some View {
        MaterialDetail(material: .constant(Material()))
            .environmentObject(Materials())
    }
}

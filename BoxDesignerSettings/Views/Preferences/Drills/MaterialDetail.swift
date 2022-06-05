//
//  MaterialDetail.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 5/28/22.
//

import SwiftUI

struct MaterialDetail: View {
    @EnvironmentObject var preferences: Preferences
    @Binding var item: Material?
    @State private var showModal = false
    @State private var delete = false

    var body: some View {
        if item != nil {
            VStack {
                ScrollView(.vertical) {
                    Form {
                        TextField("Name", text: binding.name)
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
            .navigationTitle("Material")
            .sheet(isPresented: $showModal) {
                if delete {
                    preferences.materials.remove(item: item!)
                }
            } content: {
                DeletePrompt(message: "Delete \(binding.wrappedValue.description)?", delete: $delete)
            }
        }
    }
    
    private var binding: Binding<Material> {
        Binding(get: { item! },
                set: { item! = $0 })
    }

}

struct MaterialDetail_Previews: PreviewProvider {
    static var previews: some View {
        MaterialDetail(item: .constant(Material()))
            .environmentObject(Preferences())
    }
}

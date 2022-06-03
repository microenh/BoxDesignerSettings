//
//  OpeningsDetail.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/1/22.
//

import SwiftUI

struct OpeningDetail: View {
    typealias Items = Openings

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
                    Image(systemName: "minus")
                    Image(systemName: "square.grid.3x3")
                }
            }
            .padding()
            .navigationTitle(item!.name)
            .sheet(isPresented: $showModal) {
                if delete {
                    items.remove(opening: item!)
                }
            } content: {
                DeletePrompt(message: "Delete \(item!.name)?", delete: $delete)
            }
        }
    }
}

struct OpeningsDetail_Previews: PreviewProvider {
    typealias Items = Openings
    
    static var previews: some View {
        OpeningDetail(item: .constant(Items.Item()))
            .environmentObject(Items())
    }
}

//
//  OpeningsDetail.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/1/22.
//

import SwiftUI

struct OpeningDetail: View {
    typealias Items = OpeningsView.Items

    @EnvironmentObject var items: Items
    @Binding var item: Items.Item?
    @State private var showModal = false
    @State private var delete = false

    var body: some View {
        if item != nil {
            VStack {
                Form {
                    TextField("Name", text: binding.name)
                }
                .frame(width: Misc.inputFormWidth)
                Canvas { context, size in
                    Drawing.drawOpening(context: context, size: size, item: item!,
                                        scale: Drawing.openingScale(size: size, item: item!),
                                        center: CGPoint(x: size.width / 2, y: size.height / 2))
                }
                Button {
                    showModal = true
                } label: {
                    Image(systemName: SystemImageNames.deleteItem)
                }
            }
            .navigationTitle("Opening")
            .padding()
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

struct OpeningDetail_Previews: PreviewProvider {
    static var previews: some View {
        OpeningDetail(item: .constant(OpeningDetail.Items.Item()))
            .environmentObject(OpeningDetail.Items())
    }
}

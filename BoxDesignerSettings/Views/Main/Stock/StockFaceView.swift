//
//  StockLayoutDetailView.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/15/22.
//

import SwiftUI

struct StockFaceView: View {
    
    @Binding var document: BoxDesignDocument
    let stockLayoutId: String?
    let stockFaceId: String?
    @State private var showModal = false
    @State private var delete = false

    var body: some View {
        VStack {
            Picker("Face", selection: binding.face) {
                ForEach(Face.allCases, id: \.self) { value in
                    HStack {
                        Text(value.rawValue)
                    }.tag(value)
                }
             }
            ScrollView(.vertical) {
                Form {
                    TextField("X Offset (mm)", value: binding.xOffset, format: .number)
                    TextField("Y Offset (mm)", value: binding.yOffset, format: .number)
                    Toggle(isOn: binding.rotated) {
                        Text("Rotate 90°")
                    }

                }
            }
            Spacer()
            Button {
                showModal = true
            } label: {
                Image(systemName: SystemImageNames.deleteItem)
            }
        }
        .padding()
        .navigationTitle("Stock Face")
        .sheet(isPresented: $showModal) {
            if delete {
                document.data.deleteStockFace(id: stockFaceId)
            }
        } content: {
            DeletePrompt(message: "Delete Stock Face?", delete: $delete)
        }
    }
    
    private var binding: Binding<StockFace> {
        Binding(get: { document.data.stockLayouts[stockLayoutId!]!.stockFaces[stockFaceId!]! },
                set: { document.data.stockLayouts[stockLayoutId!]!.stockFaces[stockFaceId!] = $0 })
    }

}

struct StockLayoutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StockFaceView(document: .constant(BoxDesignDocument()), stockLayoutId: nil, stockFaceId: nil)
    }
}

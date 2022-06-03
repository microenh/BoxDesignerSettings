//
//  OpeningsDetail.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/1/22.
//

import SwiftUI

struct OpeningDetail: View {
    
    @EnvironmentObject var openings: Openings
    @Binding var opening: Opening?
    @State private var showModal = false
    @State private var delete = false

    var body: some View {
        if opening != nil {
            Form {
                TextField("Name",
                          text: Binding(get: {opening!.name}, set: {opening!.name = $0}))
                Spacer()
                Button {
                    showModal = true
                } label: {
                    Image(systemName: "minus")
                    Image(systemName: "square.grid.3x3")
                }
            }
            .padding()
            .navigationTitle(opening!.name)
            .sheet(isPresented: $showModal) {
                if delete {
                    openings.remove(opening: opening!)
                }
            } content: {
                DeletePrompt(message: "Delete \(opening!.name)?", delete: $delete)
            }
        }
    }
}

struct OpeningsDetail_Previews: PreviewProvider {
    static var previews: some View {
        OpeningDetail(opening: .constant(Opening()))
            .environmentObject(Openings())
    }
}

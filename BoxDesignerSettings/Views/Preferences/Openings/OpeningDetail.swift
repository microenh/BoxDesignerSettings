//
//  OpeningsDetail.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/1/22.
//

import SwiftUI

struct OpeningDetail: View {
    @EnvironmentObject var preferences: Preferences
    @Binding var item: Opening?
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
                    Image(systemName: SystemImageNames.openings)
                }
            }
            .navigationTitle("Opening")
            .padding()
            .sheet(isPresented: $showModal) {
                if delete {
                    preferences.openings.remove(item: item!)
                }
            } content: {
                DeletePrompt(message: "Delete \(binding.wrappedValue.description)?", delete: $delete)
            }
        }
    }
    
    private var binding: Binding<Opening> {
        Binding(get: { item! },
                set: { item! = $0 })
    }

}

struct OpeningDetail_Previews: PreviewProvider {
    static var previews: some View {
        OpeningDetail(item: .constant(Opening()))
            .environmentObject(Preferences())
    }
}

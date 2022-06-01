//
//  HoleDetail.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/1/22.
//

import SwiftUI

struct HoleDetail: View {
    @EnvironmentObject var openings: Openings
    @Binding var opening: Opening?
    let holeSelection: Hole.ID?
    @State private var showModal = false
    @State private var delete = false

    
    var body: some View {
        if opening != nil,
           let holeSelection = holeSelection,
           opening!.holes[holeSelection] != nil {
            VStack {
                ScrollView(.vertical) {
                    Form {
                        TextField("Center (X)", value: hole.xCenter, format: .number)
                        TextField("Center (Y)", value: hole.yCenter, format: .number)
                    }
                }
                Spacer()
                Button {
                    showModal = true
                } label: {
                    Image(systemName: "minus")
                }
            }
            .padding()
            .navigationTitle(opening!.holes[holeSelection]!.description)
            .sheet(isPresented: $showModal) {
                if delete {
                    openings.removeHole(openingID: opening!.id, holeID: holeSelection)
                }
                
            } content: {
                DeletePrompt(message: "Delete \(opening!.holes[holeSelection]!.description)?", delete: $delete)
            }
            
        }
    }

private var hole: Binding<Hole> {
    Binding(get: { opening!.holes[holeSelection!]! },
            set: { opening!.holes[holeSelection!]! = $0 })
}


}

struct HoleDetail_Previews: PreviewProvider {
    static var previews: some View {
        HoleDetail(opening: .constant(Opening()), holeSelection: nil)
            .environmentObject(Openings())
    }
}

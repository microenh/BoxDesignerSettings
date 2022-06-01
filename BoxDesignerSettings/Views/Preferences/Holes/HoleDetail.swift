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
                Picker("Hole Type", selection: hole.type.rawValue) {
                    HStack {
                        Text("Circle")
                    }.tag(0)
                    HStack {
                        Text("Ellipse")
                    }.tag(1)
                    HStack {
                        Text("Square")
                    }.tag(2)
                    HStack {
                        Text("Rectangle")
                    }.tag(3)
                    HStack {
                        Text("Capsule")
                    }.tag(4)
                }
                ScrollView(.vertical) {
                    Form {
                        switch hole.type.rawValue.wrappedValue {
                        case 0:
                            TextField("Diameter", value: hole.xCenter, format: .number)
                        case 1:
                            TextField("Size (X)", value: hole.xCenter, format: .number)
                            TextField("Size (Y)", value: hole.xCenter, format: .number)
                        case 2:
                            TextField("Side", value: hole.xCenter, format: .number)
                        case 3:
                            TextField("Size (X)", value: hole.xCenter, format: .number)
                            TextField("Size (Y)", value: hole.xCenter, format: .number)
                        case 4:
                            TextField("Size (X)", value: hole.xCenter, format: .number)
                            TextField("Size (Y)", value: hole.xCenter, format: .number)
                        default:
                            EmptyView()
                        }
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
            .navigationTitle(opening!.holes[holeSelection]!.type.description)
            .sheet(isPresented: $showModal) {
                if delete {
                    openings.removeHole(openingID: opening!.id, holeID: holeSelection)
                }
                
            } content: {
                DeletePrompt(message: "Delete \(opening!.holes[holeSelection]!.type.description)?", delete: $delete)
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

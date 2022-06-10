//
//  SideOpeningsSidebar.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/9/22.
//

import SwiftUI

struct FaceOpeningsSidebar: View {
    
    @Binding var selection: String?
    let face: Face
    
    var body: some View {
        VStack {
            ForEach(OpeningType.allCases, id: \.self) { openingType in
                DisclosureGroup {
                    
                } label: {
                    Label(openingType.rawValue, systemImage: openingType.systemImageName)
                }

            }
            Spacer()
            HStack {
                ForEach(OpeningType.allCases, id: \.self) { openingType in
                    Button {
                        // selection = items.addNew()
                    } label: {
                        Image(systemName: SystemImageNames.addItem)
                        Image(systemName: openingType.systemImageName)
                    }
                }
            }
            .padding(.bottom)
        }
    }
}

struct FaceOpeningsSidebar_Previews: PreviewProvider {
    static var previews: some View {
        FaceOpeningsSidebar(selection: .constant(nil), face: .front)
    }
}

//
//  FaceOpeningDetail.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/10/22.
//

import SwiftUI

struct FaceOpeningDetail: View {
    @EnvironmentObject var openings: Openings
    
    @Binding var document: BoxDesignDocument
    let selection: String?
    let face: Face
    var body: some View {
        VStack {
            Canvas { context, size in
                // drawOpening(context: context, size: size)
            }

            if let selection = selection {
                if document.data.openings[face]![selection] != nil {
                    Divider()
                    FaceOpeningsOpeningDetail(document: $document,
                                              selection: selection,
                                              face: face)
                } else if document.data.slots[face]![selection] != nil {
                    Divider()
                    FaceOpeningsSlotDetail(document: $document,
                                           selection: selection,
                                           face: face)
                }
            }
        }
    }
}

struct FaceOpeningDetail_Previews: PreviewProvider {
    static var previews: some View {
        FaceOpeningDetail(document: .constant(BoxDesignDocument()),
                          selection: nil,
                          face: .front)
            .environmentObject(Openings())
    }
}

//
//  SideOpeningsOpeningDetail.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/9/22.
//

import SwiftUI

struct FaceOpeningsOpeningDetail: View {
    @Binding var selection: String?
    let face: Face
    var body: some View {
        Text("\(face.rawValue) detail")
    }
}

struct FaceOpeningsOpeningDetail_Previews: PreviewProvider {
    static var previews: some View {
        FaceOpeningsOpeningDetail(selection: .constant(nil), face: .front)
    }
}

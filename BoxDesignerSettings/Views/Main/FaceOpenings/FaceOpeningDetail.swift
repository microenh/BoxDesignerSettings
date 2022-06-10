//
//  FaceOpeningDetail.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/10/22.
//

import SwiftUI

struct FaceOpeningDetail: View {
    @Binding var selection: String?
    let face: Face
    var body: some View {
        Text("\(face.rawValue) detail")
    }
}

struct FaceOpeningDetail_Previews: PreviewProvider {
    static var previews: some View {
        FaceOpeningDetail(selection: .constant(nil), face: .front)
    }
}

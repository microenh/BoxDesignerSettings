//
//  SideView.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/9/22.
//

import SwiftUI

struct FaceOpeningsView: View {
    
    @Binding var document: BoxDesignDocument
    @State private var selection: String?
    
    var body: some View {
        TabView {
            ForEach(Face.allCases, id: \.self) { face in
                NavigationView {
                    FaceOpeningsSidebar(document: $document, selection: $selection, face: face)
                    FaceOpeningDetail(document: $document, selection: selection, face: face)
                }
                .tabItem {
                    Text(face.rawValue)
                }
            }
        }
    }
}

struct FaceView_Previews: PreviewProvider {
    static var previews: some View {
        FaceOpeningsView(document: .constant(BoxDesignDocument()))
    }
}

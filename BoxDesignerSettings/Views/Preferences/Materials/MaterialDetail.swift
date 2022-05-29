//
//  MaterialDetail.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 5/28/22.
//

import SwiftUI

struct MaterialDetail: View {
    
    @Binding var material: Material
    
    var body: some View {
        Form {
            TextField("Name",
                      text: $material.name)
        }
    }
}

struct MaterialDetail_Previews: PreviewProvider {
    static var previews: some View {
        MaterialDetail(material: .constant(Material(name: "New Material")))
    }
}

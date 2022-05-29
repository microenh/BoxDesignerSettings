//
//  MaterialsView.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 5/28/22.
//

import SwiftUI

struct MaterialsView: View {
    var body: some View {
        NavigationView {
            MaterialsSidebar()
            EmptyView()
        }
    }
}

struct MaterialsView_Previews: PreviewProvider {
    static var previews: some View {
        MaterialsView()
    }
}

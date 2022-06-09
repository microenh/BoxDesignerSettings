//
//  ContentView.swift
//  TestDocumentApp
//
//  Created by Mark Erbaugh on 6/7/22.
//

import SwiftUI

struct MainView: View {
    @Binding var document: BoxDesignDocument

    var body: some View {
        TabView {
            LayoutView(document: $document)
                .tabItem {
                    Label("Layout", systemImage: SystemImageNames.machine)
                }
            LayoutView(document: $document)
                .tabItem {
                    Label("Sides", systemImage: SystemImageNames.machine)
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    let boxDesignDocument = BoxDesignDocument()
    static var previews: some View {
        MainView(document: .constant(BoxDesignDocument()))
    }
}

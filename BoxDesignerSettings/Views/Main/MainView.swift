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
            SideOpeningsView()
                .tabItem {
                    Label("Openings", systemImage: SystemImageNames.machine)
                }
        }
        .padding()
        .frame(minWidth: 400)
    }
}

struct ContentView_Previews: PreviewProvider {
    let boxDesignDocument = BoxDesignDocument()
    static var previews: some View {
        MainView(document: .constant(BoxDesignDocument()))
    }
}

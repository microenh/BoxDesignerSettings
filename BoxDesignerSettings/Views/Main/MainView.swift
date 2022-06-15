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
            FaceOpeningsView(document: $document)
                .tabItem {
                    Label("Openings", systemImage: SystemImageNames.machine)
                }
            StockView(document: $document)
                .tabItem {
                    Label("Stock", systemImage: SystemImageNames.machine)
                }
        }
        .padding()
        .frame(minWidth: 400)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(document: .constant(BoxDesignDocument()))
    }
}

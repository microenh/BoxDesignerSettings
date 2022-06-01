//
//  ContentView.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 5/28/22.
//

import SwiftUI

struct PreferencesView: View {
    var body: some View {
        TabView {
            MachinePreferencesView()
                .tabItem {
                    Label("Machine", systemImage: "person.crop.circle")
                }
            MaterialsView()
                .tabItem {
                    Label("Materials", systemImage: "paintpalette")
                }
            DrillsView()
                .tabItem {
                    Label("Drills", systemImage: "paintpalette")
                }

        }
        .frame(width: 800, height: 400)
    }
}

struct Preferences_Previews: PreviewProvider {
    static var previews: some View {
        PreferencesView()
            .environmentObject(Machine())
            .environmentObject(Materials())
    }
}

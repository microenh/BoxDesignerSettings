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
            MachineView()
                .tabItem {
                    Label("Machine", systemImage: SystemImageNames.machine)
                }
            MaterialsView()
                .tabItem {
                    Label("Materials", systemImage: SystemImageNames.drills)
                }
            OpeningsView()
                .tabItem {
                    Label("Openings", systemImage: SystemImageNames.openings)
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
            .environmentObject(OpeningsView.Items())
    }
}

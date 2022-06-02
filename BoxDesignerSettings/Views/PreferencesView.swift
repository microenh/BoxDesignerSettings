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
                    Label("Machine", systemImage: "gearshape")
                }
            MaterialsView()
                .tabItem {
                    Label("Materials", systemImage: "square.3.layers.3d.down.right")
                }
            DrillsView()
                .tabItem {
                    Label("Drills", systemImage: "hurricane")
                }
            OpeningsView()
                .tabItem {
                    Label("Openings", systemImage: "square.grid.3x3")
                }
            HolesView()
                .tabItem {
                    Label("Holes", systemImage: "square.grid.3x3.topleft.filled")
                }
            DrillsDisclosureView()
                .tabItem {
                    Label("Disclosure", systemImage: "hurricane")
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

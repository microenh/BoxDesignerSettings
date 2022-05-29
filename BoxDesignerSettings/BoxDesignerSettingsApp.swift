//
//  BoxDesignerSettingsApp.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 5/28/22.
//

import SwiftUI

@main
struct BoxDesignerSettingsApp: App {
    
    @StateObject private var machine = Machine()
    @StateObject private var materials = Materials()

    var body: some Scene {
        WindowGroup {
            EmptyView()
        }
        Settings {
            PreferencesView()
                .environmentObject(machine)
                .environmentObject(materials)
        }
    }
}

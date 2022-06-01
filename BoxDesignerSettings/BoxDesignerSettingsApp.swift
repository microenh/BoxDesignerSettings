//
//  BoxDesignerSettingsApp.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 5/28/22.
//

import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate, ObservableObject {
    var machine: Machine?
    var materials: Materials?
    
    // close app when last window closed
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
    
    func applicationWillTerminate(_ notification: Notification) {
        machine?.save()
        materials?.save()
    }
}


@main
struct BoxDesignerSettingsApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State private var machine = Machine()
    @State private var materials = Materials()

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
    
    init() {
        appDelegate.machine = machine
        appDelegate.materials = materials
    }
}

//
//  BoxDesignerSettingsApp.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 5/28/22.
//

import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate, ObservableObject {
//    var machine: Machine?
//    var materials: Materials?
//    var openings: Openings?
    var preferences: Preferences?
    
    // close app when last window closed
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
    
    func applicationWillTerminate(_ notification: Notification) {
//        machine?.save()
//        materials?.save()
//        openings?.save()
        preferences?.save()
    }
}


@main
struct BoxDesignerSettingsApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
//    @State private var machine = Machine()
//    @State private var materials = Materials()
//    @State private var openings = Openings()
    @State private var preferences = Preferences()

    var body: some Scene {
        WindowGroup {
            EmptyView()
        }
        Settings {
            PreferencesView()
                .environmentObject(preferences)
//                .environmentObject(machine)
//                .environmentObject(materials)
//                .environmentObject(openings)
         }
    }
    
    init() {
        appDelegate.preferences = preferences
//        appDelegate.machine = machine
//        appDelegate.materials = materials
//        appDelegate.openings = openings
    }
}

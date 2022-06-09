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
    var openings: Openings?
    
// close app when last window closed - n/a for document app
//    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
//        return true
//    }
    
    func applicationWillTerminate(_ notification: Notification) {
        machine?.save()
        materials?.save()
        openings?.save()
    }
}


@main
struct BoxDesignerSettingsApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State private var machine = Machine()
    @State private var materials = Materials()
    @State private var openings = Openings()
    
    var body: some Scene {
        DocumentGroup(newDocument: BoxDesignDocument()) { file in
            ContentView(document: file.$document)
        }
        Settings {
            PreferencesView()
                .environmentObject(machine)
                .environmentObject(materials)
                .environmentObject(openings)
        }
    }
    
    init() {
        appDelegate.machine = machine
        appDelegate.materials = materials
        appDelegate.openings = openings
    }
}

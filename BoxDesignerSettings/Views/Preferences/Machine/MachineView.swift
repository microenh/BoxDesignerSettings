//
//  MachinePreferencesView.swift
//  BoxDesignerDoc
//
//  Created by Mark Erbaugh on 5/26/22.
//

import SwiftUI

struct MachineView: View {
    @EnvironmentObject private var preferences: Preferences

    var body: some View {
        Form {
            TextField("Max RPM",
                      value: $preferences.maxRPM,
                      format: .number)
            TextField("Safe Height",
                      value: $preferences.safeHeight,
                      format: .number)
            TextField("Extra Cut",
                      value: $preferences.extraCut,
                      format: .number)
            TextField("H Rapid Speed",
                      value: $preferences.horizontalRapid,
                      format: .number)
            TextField("V Rapid Speed",
                      value: $preferences.verticalRapid,
                      format: .number)
            TextField("Finger Variance",
                      value: $preferences.fingerVariance,
                      format: .number)
        }
        .frame(maxWidth: 200)
    }
}

struct MachinePreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        MachineView()
            .environmentObject(Preferences())

    }
}

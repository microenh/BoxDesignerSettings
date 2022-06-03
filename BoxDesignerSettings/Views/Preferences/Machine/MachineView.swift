//
//  MachinePreferencesView.swift
//  BoxDesignerDoc
//
//  Created by Mark Erbaugh on 5/26/22.
//

import SwiftUI

struct MachineView: View {
    @EnvironmentObject private var machine: Machine

    var body: some View {
        Form {
            TextField("Max RPM",
                      value: $machine.maxRPM,
                      format: .number)
            TextField("Safe Height",
                      value: $machine.safeHeight,
                      format: .number)
            TextField("Extra Cut",
                      value: $machine.extraCut,
                      format: .number)
            TextField("H Rapid Speed",
                      value: $machine.horizontalRapid,
                      format: .number)
            TextField("V Rapid Speed",
                      value: $machine.verticalRapid,
                      format: .number)
            TextField("Finger Variance",
                      value: $machine.fingerVariance,
                      format: .number)
        }
        .frame(maxWidth: 200)
    }
}

struct MachinePreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        MachineView()
            .environmentObject(Machine())

    }
}

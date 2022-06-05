//
//  MachinePreferencesView.swift
//  BoxDesignerDoc
//
//  Created by Mark Erbaugh on 5/26/22.
//

import SwiftUI

struct MachineView: View {
    typealias Item = Machine
    @EnvironmentObject private var item: Item

    var body: some View {
        ScrollView(.vertical) {
            Form {
                TextField("Max RPM",
                          value: $item.maxRPM,
                          format: .number)
                TextField("Safe Height (mm)",
                          value: $item.safeHeight,
                          format: .number)
                TextField("Extra Cut (mm)",
                          value: $item.extraCut,
                          format: .number)
                TextField("H Rapid Speed (mm/min)",
                          value: $item.horizontalRapid,
                          format: .number)
                TextField("V Rapid Speed (mm/min)",
                          value: $item.verticalRapid,
                          format: .number)
                TextField("Finger Variance (mm)",
                          value: $item.fingerVariance,
                          format: .number)
            }
            .frame(width: Misc.inputFormWidth)
            .padding(.top)
        }
    }
}

struct MachinePreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        MachineView()
            .environmentObject(MachineView.Item())

    }
}

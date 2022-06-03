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
        Form {
            TextField("Max RPM",
                      value: $item.maxRPM,
                      format: .number)
            TextField("Safe Height",
                      value: $item.safeHeight,
                      format: .number)
            TextField("Extra Cut",
                      value: $item.extraCut,
                      format: .number)
            TextField("H Rapid Speed",
                      value: $item.horizontalRapid,
                      format: .number)
            TextField("V Rapid Speed",
                      value: $item.verticalRapid,
                      format: .number)
            TextField("Finger Variance",
                      value: $item.fingerVariance,
                      format: .number)
        }
        .frame(maxWidth: 200)
    }
}

struct MachinePreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        MachineView()
            .environmentObject(MachineView.Item())

    }
}

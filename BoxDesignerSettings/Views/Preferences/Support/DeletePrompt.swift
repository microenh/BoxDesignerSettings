//
//  DeletePrompt.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 5/31/22.
//

import SwiftUI

struct DeletePrompt: View {
    @Environment(\.presentationMode) var presentation
    let message: String
    @Binding var delete: Bool

    var body: some View {
        VStack {
            Text(message)
            HStack {
                Button("Yes") {
                    delete = true
                    self.presentation.wrappedValue.dismiss()
                }
                Button("No") {
                    delete = false
                    self.presentation.wrappedValue.dismiss()
                }
            }
        }
        .padding()
    }
}

struct DeletePrompt_Previews: PreviewProvider {
    static var previews: some View {
        DeletePrompt(message: "Delete?", delete: .constant(false))
    }
}

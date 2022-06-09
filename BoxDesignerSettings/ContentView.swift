//
//  ContentView.swift
//  TestDocumentApp
//
//  Created by Mark Erbaugh on 6/7/22.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: BoxDesignDocument

    var body: some View {
        ScrollView(.vertical) {
            Form {
                TextField("Title", text: $document.data.name)
                Toggle(isOn: $document.data.front) { Text("Front") }
                Toggle(isOn: $document.data.rear) { Text("Rear") }
                Toggle(isOn: $document.data.top) { Text("Top") }
                Toggle(isOn: $document.data.bottom) { Text("Bottom") }
                Toggle(isOn: $document.data.left) { Text("Left") }
                Toggle(isOn: $document.data.right) { Text("Right") }
            }
            .frame(width: Misc.inputFormWidth)
            .padding()
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(BoxDesignDocument()))
    }
}

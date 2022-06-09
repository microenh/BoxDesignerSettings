//
//  LayoutView.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/9/22.
//

import SwiftUI

struct LayoutView: View {
    @Binding var document: BoxDesignDocument
    @EnvironmentObject var materials: Materials

    var body: some View {
        // ScrollView(.vertical) {
        VStack(alignment: .center) {
            HStack {
                GroupBox {
                    Text("Comment")
                    Form {
                        TextEditor(text: $document.data.comment)
                            .frame(height: 120)
                    }
                }
                GroupBox {
                    Text("Faces")
                    Form {
                        HStack {
                            Toggle(isOn: $document.data.front) { Text("Front") }
                                .frame(width: 80, alignment: .leading)
                            Toggle(isOn: $document.data.rear) { Text("Rear") }
                                .frame(width: 80, alignment: .leading)
                        }
                        HStack {
                            Toggle(isOn: $document.data.top) { Text("Top") }
                                .frame(width: 80, alignment: .leading)
                            Toggle(isOn: $document.data.bottom) { Text("Bottom") }
                                .frame(width: 80, alignment: .leading)
                        }
                        HStack {
                            Toggle(isOn: $document.data.left) { Text("Left") }
                                .frame(width: 80, alignment: .leading)
                            Toggle(isOn: $document.data.right) { Text("Right") }
                                .frame(width: 80, alignment: .leading)
                        }
                    }
                }
            }
            HStack {
                GroupBox {
                    Text("Box Size")
                    Form {
                        TextField("Width",
                                  value: $document.data.width,
                                  format: .number)
                        TextField("Height",
                                  value: $document.data.height,
                                  format: .number)
                        TextField("Depth",
                                  value: $document.data.depth,
                                  format: .number)
                        TextField("Finger Multiple",
                                  value: $document.data.fingerMultiple,
                                  format: .number)
                    }
                }
                GroupBox {
                    Text("Stock")
                    Form {
                        Picker("Material", selection: $document.data.materialId) {
                            ForEach(Array(materials.items.values)) { material in
                                HStack {
                                    Text(material.name)
                                }
                            }
                        }
                        
                        TextField("Width",
                                  value: $document.data.stockWidth,
                                  format: .number)
                        TextField("Length",
                                  value: $document.data.stockLength,
                                  format: .number)
                        TextField("Thickness",
                                  value: $document.data.stockThickness,
                                  format: .number)
                    }
                }
            }
            drillsView
        }
        .padding()
    }
    
    var drillsView: some View {
        GroupBox {
            Text("Drills")
            Form {
                Picker("Rough", selection: $document.data.roughDrill) {
                    if let material = materials[document.data.materialId] {
                        ForEach(Array(material.detailItems.values)) { drill in
                            HStack {
                                Text(drill.description)
                            }
                        }
                    }
                }
                HStack {
                    Picker("Finish", selection: $document.data.finishDrill) {
                        if let material = materials[document.data.materialId] {
                            ForEach(Array(material.detailItems.values)) { drill in
                                HStack {
                                    Text(drill.description)
                                }
                            }
                        }
                    }
                    Button("Clear") {
                        document.data.finishDrill = ""
                    }
                }
            }
        }

    }
}

struct LayoutView_Previews: PreviewProvider {
    static var previews: some View {
        LayoutView(document: .constant(BoxDesignDocument()))
    }
}

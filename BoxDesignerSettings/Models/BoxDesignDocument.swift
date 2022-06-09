//
//  TestDocumentAppDocument.swift
//  TestDocumentApp
//
//  Created by Mark Erbaugh on 6/7/22.
//

import SwiftUI
import UniformTypeIdentifiers

extension UTType {
    static let boxdesigner = UTType(exportedAs: "com.microenh.boxdesigner", conformingTo: .json)
    static let writableContentTypes = [UTType.boxdesigner]
}

struct BoxDesignDocument: FileDocument, Codable {
    var data: BoxModel

    init() {
        self.data = BoxModel()
    }

    static let readableContentTypes = [UTType.boxdesigner]

    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        self.data = try JSONDecoder().decode(BoxModel.self, from: data)
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = try JSONEncoder().encode(data)
        return .init(regularFileWithContents: data)
    }
}

//
//  Openings.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/1/22.
//

import Foundation

struct Opening: Identifiable, Codable {
    
    let id: String
    var name: String
    var holes: [String: Hole]
    
    init(id: String = "M" + UUID().uuidString,
         name: String = "",
         holes: [String: Hole] = [String: Hole]()) {
        self.id = id
        self.name = name
        self.holes = holes
    }

    subscript(holeID: Hole.ID?) -> Hole? {
        get {
            if let id = holeID {
                return holes[id]
            }
            return nil
        }

        set(newValue) {
            if let id = holeID {
                holes[id] = newValue
            }
        }
    }
}

class Openings: ObservableObject {
    @Published var openings = [String: Opening]()
    
    static let fileName = "openings"
    static let fileExtension = "json"
    
    static private var databaseFileUrl: URL {
        FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
            .appendingPathComponent(Self.fileName)
            .appendingPathExtension(Self.fileExtension)
    }

    init() {
        func loadData(from storeFileData: Data) -> [String: Opening] {
            do {
                let decoder = JSONDecoder()
                return try decoder.decode([String: Opening].self, from: storeFileData)
            } catch {
                print(error)
                return [String: Opening]()
            }
        }
        
        if let data = FileManager.default.contents(atPath: Self.databaseFileUrl.path) {
            openings = loadData(from: data)
        } else {
            if let bundledDatabaseUrl = Bundle.main.url(forResource: Self.fileName, withExtension: Self.fileExtension) {
                if let data = FileManager.default.contents(atPath: bundledDatabaseUrl.path) {
                    openings = loadData(from: data)
                } else {
                    openings = [String: Opening]()
                }
            }
        }
     }
    
    func save() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            let data = try encoder.encode(openings)
            if FileManager.default.fileExists(atPath: Self.databaseFileUrl.path) {
                try FileManager.default.removeItem(at: Self.databaseFileUrl)
            }
            try data.write(to: Self.databaseFileUrl)
        } catch {
            //..
        }
    }

    subscript(openingID: Opening.ID?) -> Opening? {
        get {
            if let id = openingID {
                return openings[id]
            }
            return nil
        }

        set(newValue) {
            if let id = openingID {
                openings[id] = newValue
            }
        }
    }
    
    func addNew() -> Opening.ID {
        let x = Opening(name: "NEW OPENING")
        openings[x.id] = x
        return x.id
    }
    
    func remove(opening: Opening) {
        openings[opening.id] = nil
    }
    
    func addNewHole(openingID: Opening.ID?) -> Hole.ID {
        let x = Hole()
        if let openingID = openingID,
           openings[openingID] != nil {
            openings[openingID]!.holes[x.id] = x
        }
        return x.id
    }
    
    func removeHole(openingID: Opening.ID?, holeID: Hole.ID?) {
        if let openingID = openingID,
           let holeID = holeID,
           openings[openingID] != nil {
            openings[openingID]!.holes[holeID] = nil
        }
    }
    
    func getOpeningID(id: String?) -> String? {
        var openingId: String? = nil
        if let id = id {
            if id.starts(with: "M") {
                return id
            } else {
                for opening in openings.values {
                    if opening.holes[id] != nil {
                        openingId = opening.id
                        break
                    }
                }
            }
        }
        return openingId
    }

}

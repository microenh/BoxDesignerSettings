//
//  Materials.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 5/28/22.
//

import Foundation

struct Material: Identifiable, Codable {
    
    static func == (lhs: Material, rhs: Material) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: String
    var name: String
    var drills: [String: Drill]
    
    init(id: String = UUID().uuidString,
         name: String = "",
         drills: [String: Drill] = [String: Drill]()) {
        self.id = id
        self.name = name
        self.drills = drills
    }
    
    subscript(drillID: Drill.ID?) -> Drill? {
        get {
            if let id = drillID {
                return drills[id]
            }
            return nil
        }

        set(newValue) {
            if let id = drillID {
                drills[id] = newValue
            }
        }
    }
    
}

class Materials: ObservableObject {
    @Published var materials = [String: Material]()
    
    static let fileName = "materials"
    static let fileExtension = "json"
    
    static private var databaseFileUrl: URL {
        FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
            .appendingPathComponent(Self.fileName)
            .appendingPathExtension(Self.fileExtension)
    }

    init() {
        func loadData(from storeFileData: Data) -> [String: Material] {
            do {
                let decoder = JSONDecoder()
                return try decoder.decode([String: Material].self, from: storeFileData)
            } catch {
                print(error)
                return [String: Material]()
            }
        }
        
        if let data = FileManager.default.contents(atPath: Self.databaseFileUrl.path) {
            materials = loadData(from: data)
        } else {
            if let bundledDatabaseUrl = Bundle.main.url(forResource: Self.fileName, withExtension: Self.fileExtension) {
                if let data = FileManager.default.contents(atPath: bundledDatabaseUrl.path) {
                    materials = loadData(from: data)
                } else {
                    materials = [String: Material]()
                }
            }
        }
     }
    
    func save() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            let data = try encoder.encode(materials)
            if FileManager.default.fileExists(atPath: Self.databaseFileUrl.path) {
                try FileManager.default.removeItem(at: Self.databaseFileUrl)
            }
            try data.write(to: Self.databaseFileUrl)
        } catch {
            //..
        }
    }

    subscript(materialID: Material.ID?) -> Material? {
        get {
            if let id = materialID {
                return materials[id]
            }
            return nil
        }

        set(newValue) {
            if let id = materialID {
                materials[id] = newValue
            }
        }
    }
    
    func addNew() -> Material.ID {
        let x = Material()
        materials[x.id] = x
        return x.id
    }
    
    func remove(material: Material) {
        materials[material.id] = nil
    }
    
    func addNewDrill(materialID: Material.ID?) -> Drill.ID {
        let x = Drill(type: "end mill")
        if let materialID = materialID,
           materials[materialID] != nil {
            materials[materialID]!.drills[x.id] = x
        }
        return x.id
    }
    
    func removeDrill(materialID: Material.ID?, drillID: Drill.ID?) {
        if let materialID = materialID,
           let drillID = drillID,
           materials[materialID] != nil {
            materials[materialID]!.drills[drillID] = nil
        }
    }
    

}

//
//  Materials.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 5/28/22.
//

import Foundation

struct Material: Identifiable, Codable {
    typealias DetailItem = Drill
    
    let id: String
    var name: String
    var minChipLoad1mm: Double
    var maxChipLoad1mm: Double
    var minChipLoad3mm: Double
    var maxChipLoad3mm: Double
    var minChipLoad6mm: Double
    var maxChipLoad6mm: Double
    var detailItems: [String: DetailItem]
    
    init(id: String = UUID().uuidString,
         name: String = "",
         minChipLoad1mm: Double = 0.0,
         maxChipLoad1mm: Double = 0.0,
         minChipLoad3mm: Double = 0.0,
         maxChipLoad3mm: Double = 0.0,
         minChipLoad6mm: Double = 0.0,
         maxChipLoad6mm: Double = 0.0,
         detailItems: [String: DetailItem] = [String: DetailItem]()) {
        self.id = id
        self.name = name
        self.minChipLoad1mm = minChipLoad1mm
        self.maxChipLoad1mm = maxChipLoad1mm
        self.minChipLoad3mm = minChipLoad3mm
        self.maxChipLoad3mm = maxChipLoad3mm
        self.minChipLoad6mm = minChipLoad6mm
        self.maxChipLoad6mm = maxChipLoad6mm
        self.detailItems = detailItems
    }
    
    subscript(id: String?) -> DetailItem? {
        get {
            if let id = id {
                return detailItems[id]
            }
            return nil
        }

        set(newValue) {
            if let id = id {
                detailItems[id] = newValue
            }
        }
    }
    
    var description: String {
        name
    }
    
}

class Materials: ObservableObject {
    typealias Item = Material
    @Published var items = [String: Item]()
    
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
            items = loadData(from: data)
        } else {
            if let bundledDatabaseUrl = Bundle.main.url(forResource: Self.fileName, withExtension: Self.fileExtension) {
                if let data = FileManager.default.contents(atPath: bundledDatabaseUrl.path) {
                    items = loadData(from: data)
                } else {
                    items = [String: Material]()
                }
            }
        }
     }
    
    func save() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            let data = try encoder.encode(items)
            if FileManager.default.fileExists(atPath: Self.databaseFileUrl.path) {
                try FileManager.default.removeItem(at: Self.databaseFileUrl)
            }
            try data.write(to: Self.databaseFileUrl)
        } catch {
            //..
        }
    }

    subscript(id: String?) -> Item? {
        get {
            if let id = id {
                return items[id]
            }
            return nil
        }

        set(newValue) {
            if let id = id {
                items[id] = newValue
            }
        }
    }
    
    func addNew() -> String {
        let x = Item(name: "NEW MATERIAL")
        items[x.id] = x
        return x.id
    }
    
    func remove(item: Item) {
        items[item.id] = nil
    }
    
    func addNewDetail(id: String?) -> String {
        let item = Item.DetailItem(type: "NEW DRILL")
        if let id = id,
           items[id] != nil {
            items[id]!.detailItems[item.id] = item
        }
        return item.id
    }
    
    func removeDetail(id: String?) {
        if let id = id,
           let masterId = getMasterId(id: id) {
            items[masterId]!.detailItems[id] = nil
        }
    }
    
    func getMasterId(id: String?) -> String? {
        var masterId: String? = nil
        if let id = id {
            if items[id] == nil {
                for material in items.values {
                    if material.detailItems[id] != nil {
                        masterId = material.id
                        break
                    }
                }
            } else {
                return id
            }
        }
        return masterId
    }
}

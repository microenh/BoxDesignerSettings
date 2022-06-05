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
    var detailItems: [String: DetailItem]
    
    init(id: String = UUID().uuidString,
         name: String = "",
         detailItems: [String: DetailItem] = [String: DetailItem]()) {
        self.id = id
        self.name = name
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
    
    init(items: [String: Item]) {
        self.items = items
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

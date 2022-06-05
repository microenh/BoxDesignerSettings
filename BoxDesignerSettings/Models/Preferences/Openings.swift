//
//  Openings.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/1/22.
//

import Foundation

struct Opening: Identifiable, Codable {
    typealias DetailItem = Slot
    
    let id: String
    var name: String
    var detailItems: [String: DetailItem]
    
    init(id: String = UUID().uuidString,
         name: String = "NEW OPENING",
         detailItems: [String: Slot] = [String: DetailItem]()) {
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

class Openings: ObservableObject {
    typealias Item = Opening
    
    @Published var items = [String: Item]()
    
    static let fileName = "openings"
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
        let item = Item()
        items[item.id] = item
        return item.id
    }
    
    func remove(item: Item) {
        items[item.id] = nil
    }
    
    func addDetail(id: String?) -> String {
        let item = Item.DetailItem()
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
                for item in items.values {
                    if item.detailItems[id] != nil {
                        masterId = item.id
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

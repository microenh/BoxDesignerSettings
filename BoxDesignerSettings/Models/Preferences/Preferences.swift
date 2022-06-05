//
//  PreferencesModel.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/3/22.
//

import SwiftUI

class Preferences: ObservableObject {
    @Published var maxRPM = 0.0
    @Published var safeHeight = 0.0
    @Published var extraCut = 0.0  // cut into spoilboard
    @Published var horizontalRapid = 0.0
    @Published var verticalRapid = 0.0
    @Published var fingerVariance = 0.0  // male fingers slightly smaller, female fingers slightly larger
    
    @Published var materials = Materials()
    @Published var openings = Openings()

    static let fileName = "preferences"
    static let fileExtension = "json"

    static var databaseFileUrl: URL {
        FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
            .appendingPathComponent(Self.fileName)
            .appendingPathExtension(Self.fileExtension)
    }
    
    private struct PreferencesData: Codable {
        let maxRPM: Double
        let safeHeight: Double
        let extraCut: Double
        let horizontalRapid: Double
        let verticalRapid: Double
        let fingerVariance: Double
        let materials: [String: Material]
        let openings: [String: Opening]
        
        init(maxRPM: Double = 0.0,
             safeHeight: Double = 0.0,
             extraCut: Double = 0.0,
             horizontalRapid: Double = 0.0,
             verticalRapid: Double = 0.0,
             fingerVariance: Double = 0.0,
             materials: [String: Material] = [String: Material](),
             openings: [String: Opening] = [String: Opening]()) {
            self.maxRPM = maxRPM
            self.safeHeight = safeHeight
            self.extraCut = extraCut
            self.horizontalRapid = horizontalRapid
            self.verticalRapid = verticalRapid
            self.fingerVariance = fingerVariance
            self.materials = materials
            self.openings = openings
        }
    }
    
    private init (data: PreferencesData) {
        maxRPM = data.maxRPM
        safeHeight = data.safeHeight
        extraCut = data.extraCut
        horizontalRapid = data.horizontalRapid
        verticalRapid = data.verticalRapid
        fingerVariance = data.fingerVariance
        materials = Materials(items: data.materials)
        openings = Openings(items: data.openings)
    }

    convenience init() {
        func loadData(from storeFileData: Data) -> PreferencesData {
            do {
                let decoder = JSONDecoder()
                return try decoder.decode(PreferencesData.self, from: storeFileData)
            } catch {
                print(error)
                return PreferencesData()
            }
        }
        
        if let data = FileManager.default.contents(atPath: Self.databaseFileUrl.path) {
            self.init(data: loadData(from: data))
        } else {
            if let bundledDatabaseUrl = Bundle.main.url(forResource: Self.fileName, withExtension: Self.fileExtension) {
                if let data = FileManager.default.contents(atPath: bundledDatabaseUrl.path) {
                    self.init(data: loadData(from: data))
                } else {
                    self.init(data: PreferencesData())
                }
            } else {
                self.init(data: PreferencesData())
            }
        }
    }
        
    func save() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            let db = PreferencesData(maxRPM: maxRPM,
                                     safeHeight: safeHeight,
                                     extraCut: extraCut,
                                     horizontalRapid: horizontalRapid,
                                     verticalRapid: verticalRapid,
                                     fingerVariance: fingerVariance,
                                     materials: materials.items,
                                     openings: openings.items)
            let data = try encoder.encode(db)
            if FileManager.default.fileExists(atPath: Self.databaseFileUrl.path) {
                try FileManager.default.removeItem(at: Self.databaseFileUrl)
            }
            try data.write(to: Self.databaseFileUrl)
        } catch {
            //..
        }
    }
}

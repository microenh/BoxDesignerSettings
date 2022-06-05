//
//  Machine.swift
//  BoxDesignerDoc
//
//  Created by Mark Erbaugh on 5/27/22.
//

import Foundation

private struct MachineData: Codable {
    let maxRPM: Double
    let safeHeight: Double
    let extraCut: Double
    let horizontalRapid: Double
    let verticalRapid: Double
    let fingerVariance: Double
    
    init(maxRPM: Double = 0.0,
         safeHeight: Double = 0.0,
         extraCut: Double = 0.0,
         horizontalRapid: Double = 0.0,
         verticalRapid: Double = 0.0,
         fingerVariance: Double = 0.0) {
        self.maxRPM = maxRPM
        self.safeHeight = safeHeight
        self.extraCut = extraCut
        self.horizontalRapid = horizontalRapid
        self.verticalRapid = verticalRapid
        self.fingerVariance = fingerVariance
    }
}


class Machine: ObservableObject {
    @Published var maxRPM = 0.0
    @Published var safeHeight = 0.0
    @Published var extraCut = 0.0  // cut into spoilboard
    @Published var horizontalRapid = 0.0
    @Published var verticalRapid = 0.0
    @Published var fingerVariance = 0.0  // male fingers slightly smaller, female fingers slightly larger

    static let fileName = "machine"
    static let fileExtension = "json"

    static var databaseFileUrl: URL {
        FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
            .appendingPathComponent(Self.fileName)
            .appendingPathExtension(Self.fileExtension)
    }
    
    private init (db: MachineData) {
        maxRPM = db.maxRPM
        safeHeight = db.safeHeight
        extraCut = db.extraCut
        horizontalRapid = db.horizontalRapid
        verticalRapid = db.verticalRapid
        fingerVariance = db.fingerVariance
    }

    convenience init() {
        func loadData(from storeFileData: Data) -> MachineData {
            do {
                let decoder = JSONDecoder()
                return try decoder.decode(MachineData.self, from: storeFileData)
            } catch {
                print(error)
                return MachineData()
            }
        }
        
        if let data = FileManager.default.contents(atPath: Self.databaseFileUrl.path) {
            self.init(db: loadData(from: data))
        } else {
            if let bundledDatabaseUrl = Bundle.main.url(forResource: Machine.fileName, withExtension: Machine.fileExtension) {
                if let data = FileManager.default.contents(atPath: bundledDatabaseUrl.path) {
                    self.init(db: loadData(from: data))
                } else {
                    self.init(db: MachineData())
                }
            } else {
                self.init(db: MachineData())
            }
        }
    }
        
    func save() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            let db = MachineData(maxRPM: maxRPM,
                              safeHeight: safeHeight,
                              extraCut: extraCut,
                              horizontalRapid: horizontalRapid,
                              verticalRapid: verticalRapid,
                              fingerVariance: fingerVariance)
            let data = try encoder.encode(db)
            if FileManager.default.fileExists(atPath: Machine.databaseFileUrl.path) {
                try FileManager.default.removeItem(at: Machine.databaseFileUrl)
            }
            try data.write(to: Machine.databaseFileUrl)
        } catch {
            //..
        }
    }
}

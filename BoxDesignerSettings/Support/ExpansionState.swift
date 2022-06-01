/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The expansion state for the side bar.
*/

import Foundation

struct ExpansionState: RawRepresentable {
    typealias RawValue = String
    
    private var ids: Set<RawValue>
    
    init() {
        ids = []
    }

    var isEmpty: Bool {
        ids.isEmpty
    }
    
    init?(rawValue: String) {
        ids = Set(rawValue.components(separatedBy: ","))
    }
    
    var rawValue: String {
        ids.map({ "\($0)" }).joined(separator: ",")
    }

    func contains(_ id: RawValue) -> Bool {
        ids.contains(id)
    }

    mutating func insert(_ id: RawValue) {
        ids.insert(id)
    }

    mutating func remove(_ id: RawValue) {
        ids.remove(id)
    }

    subscript(string: RawValue) -> Bool {
        get {
            ids.contains(string)
        }
        set {
            if newValue {
                ids.insert(string)
            } else {
                ids.remove(string)
            }
        }
    }
}

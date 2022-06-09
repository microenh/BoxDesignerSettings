//
//  Box.swift
//  BoxDesignerSettings
//
//  Created by Mark Erbaugh on 6/8/22.
//

import Foundation


struct BoxModel: Codable {
    var name: String
    var front: Bool
    var rear: Bool
    var left: Bool
    var right: Bool
    var top: Bool
    var bottom: Bool
    
    init() {
        name = ""
        front = true
        rear = true
        left = true
        right = true
        top = true
        bottom = true
    }
}

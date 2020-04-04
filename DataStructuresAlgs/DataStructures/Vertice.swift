//
//  Vertice.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 01.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

class Vertice: NSObject, Comparable {
    
    static func < (lhs: Vertice, rhs: Vertice) -> Bool {
        return lhs.distanceTo < rhs.distanceTo
    }
    
    static func == (lhs: Vertice, rhs: Vertice) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: Int
    var inboundCount: Int = 0
    var distanceTo: Int = 0
    
    init(id: Int) {
        self.id = id
    }
}

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
    
    //Needed for topological sort:
    var inboundCount: Int = 0
    
    //Needed for Djikstra + Prim's MST (weight):
    var distanceTo: Int = 0
    
    //Needed for Prim's MST:
    var minIngoingEdge: Edge?
    
    var weight: Int {
        get {
            return distanceTo
        }
        set (weight) {
            distanceTo = weight
        }
    }
    
    init(id: Int) {
        self.id = id
    }
}

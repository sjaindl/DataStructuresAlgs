//
//  Edge.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 02.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

class Edge {
    let vertice: Vertice
    let weight: Int
    
    init(vertice: Vertice, weight: Int) {
        self.vertice = vertice
        self.weight = weight
    }
}

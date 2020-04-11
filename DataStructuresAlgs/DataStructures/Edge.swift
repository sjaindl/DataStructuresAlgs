//
//  Edge.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 02.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

class Edge {
    let from: Vertice
    let to: Vertice
    let weight: Int
    
    init(from: Vertice, to: Vertice, weight: Int) {
        self.from = from
        self.to = to
        self.weight = weight
    }
}

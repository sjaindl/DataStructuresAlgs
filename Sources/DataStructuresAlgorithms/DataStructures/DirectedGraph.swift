//
//  DirectedGraph.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 01.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

class DirectedGraph {
    let vertices: [Vertice]
    var adjList: [LinkedList<Vertice>] = []
    
    init(vertices: [Vertice]) {
        self.vertices = vertices
        
        for _ in vertices {
            adjList.append(LinkedList<Vertice>())
        }
    }
    
    func addEdge(v1: Vertice, v2: Vertice) {
        adjList[v1.id].add(node: Node(val: v2))
    }
    
    func neighbours(v: Vertice) -> LinkedList<Vertice> {
        return adjList[v.id]
    }
}

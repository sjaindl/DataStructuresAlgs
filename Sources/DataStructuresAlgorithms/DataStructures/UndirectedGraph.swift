//
//  UndirectedGraph.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 27.03.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

class UndirectedGraph {
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
        adjList[v2.id].add(node: Node(val: v1))
    }
    
    func neighbours(v: Vertice) -> LinkedList<Vertice> {
        return adjList[v.id]
    }
}

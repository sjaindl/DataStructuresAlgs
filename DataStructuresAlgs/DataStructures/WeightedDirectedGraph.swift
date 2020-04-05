//
//  WeightedDirectedGraph.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 02.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

class WeightedDirectedGraph {
    let vertices: [Vertice]
    var adjList: [LinkedList<Edge>] = []
    
    init(vertices: [Vertice]) {
        self.vertices = vertices
        
        for _ in vertices {
            adjList.append(LinkedList<Edge>())
        }
    }
    
    func addEdge(v1: Vertice, v2: Vertice, weight: Int) {
        let edge = Edge(vertice: v2, weight: weight)
        adjList[v1.id].add(node: Node(val: edge))
    }
    
    func neighbours(v: Vertice) -> LinkedList<Edge> {
        return adjList[v.id]
    }
}